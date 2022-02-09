using JuMP
using CPLEX

include("parser.jl")

start = time()

function Mymodel(MyFileName::String)
  P, Nm, Nf, C, G, A, T, init, y = read_instance(MyFileName)
  nbAllele = A * G
  theta = Array{Float64,1}(zeros(T))
  for i in 1:T
    theta[i] = init^((T-i)/(T-1))
  end

  # Create the model
  m = Model(CPLEX.Optimizer)

  ## Variables
  @variable(m, x[1:P] >= 0, Int)
  @variable(m, t[1:nbAllele] >= 0)
  @variable(m, z[1:nbAllele] >= 0)

  ## Constraints
  @constraint(m, sum(x[i] for i in 1:Nm) == P)
  @constraint(m, sum(x[i] for i in Nm+1:P) == P)
  @constraint(m, [j in 1:nbAllele], z[j] >= t[j] - sum(x[i] for i in 1:P if y[i,j] == 2))
  @constraint(m, [j in 1:nbAllele, h in 1:T], log(theta[h]) + ((t[j] - theta[h]) / theta[h]) >= sum(log(y[i,j])*x[i] for i in 1:P if y[i,j] == 1))
  @constraint(m, [i in 1:P], x[i] <= 3) # limiter nombre d'enfant par individu

  ## Objective
  @objective(m, Min, sum(z[j] for j in 1:nbAllele))

  #resolution
  optimize!(m)

  println(solution_summary(m, verbose=true))
  x_vals = JuMP.getvalue.( m[:x] )
  println(x_vals)

end

Mymodel("DivGenetique_ampl.dat")
