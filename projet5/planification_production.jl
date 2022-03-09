using JuMP
using CPLEX
using Plots

function Rolling(Tprim::Int64)
  T, M, Emax = 12, 6, 3
  f = [10,30,60,90, 10, 30]
  e = [8,6,4,2, 8, 6]
  h = Array{Int64,1}(ones(T))
  p = Array{Int64,2}(zeros(T,M))
  d = Array{Int64,1}(ones(T))
  for t in 1:T
    d[t] = rand(20:70)
  end

  # Create the model
  model = Model(CPLEX.Optimizer)

  ## Variables
  @variable(model, x[1:T,1:M] >= 0)
  @variable(model, y[1:T,1:M], Bin)
  @variable(model, s[1:T+1] >= 0)

  ## Constraints
  @constraint(model, s[1] == 0)
  @constraint(model, [t in 2:T+1], sum(x[t-1,m] - s[t] + s[t-1] for m in 1:M) == d[t-1])
  @constraint(model, [t in 1:T, m in 1:M], x[t,m] <= y[t,m]*sum(d[tprim] for tprim in t:T))
  @constraint(model, [t in 1:(T-Tprim)], sum((e[m] - Emax)*x[tprim,m] for tprim in t:(t+Tprim), m in 1:M) <= 0)

  ## Objective
  @objective(model, Min, sum(f[m]*y[t,m] for m in 1:M, t in 1:T) + sum(s[t] for t in  1:T+1))

  #resolution
  optimize!(model)

  x_sol = JuMP.getvalue.(model[:x])
  cout_carbone = sum(e[m]*x_sol[t,m] for m in 1:M, t in 1:T)
  println(fout, "cout carbone = ", cout_carbone)
  println(fout, "objective value = ", JuMP.getobjectivevalue.(model))
  return cout_carbone, JuMP.getobjectivevalue.(model)
end

fout = open("resultatsEmax3M6.txt", "w")

T = 12
cout_carbone_history = Array{Float64,1}(zeros(T))
cout_history = Array{Float64,1}(zeros(T))

for Tprim in 1:T
  start = time()
  println(fout, "Tprim = ", Tprim)
  cout_carbone, cout = Rolling(Tprim)
  cout_carbone_history[Tprim] = cout_carbone
  cout_history[Tprim] = cout
  println(fout, "execution time = ", time() - start, "s")
end
close(fout)

plot(1:T,cout_carbone_history)
xlabel!("Tprim")
ylabel!("cout carbone")

plot(1:T,cout_history)
xlabel!("Tprim")
ylabel!("cout")
