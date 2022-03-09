using JuMP
using CPLEX


start = time()

function Rolling()
  T, M, Emax = 12, 4, 3
  f = [10,30,60,90]
  e = [8,6,4,2]
  h = Array{Int64,1}(ones(T))
  p = Array{Int64,2}(zeros(T,M))
  d = Array{Int64,1}(ones(T))
  for t in 1:T
    d[t] = rand(20:70)
  end

  # Create the model
  m = Model(CPLEX.Optimizer)

  ## Variables
  @variable(m, x[], Bin)
  @variable(m, y[] >= 0)

  ## Constraints
  @constraint(m, )

  ## Objective
  @objective(m, Max, )

  #resolution
  optimize!(m)

  # solution_summary(m, verbose=true)
  # z_vals = JuMP.getvalue.( m[:z] )
  # println(z_vals)

end

Rolling()
