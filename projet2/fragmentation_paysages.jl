using JuMP
using CPLEX

include("parser.jl")

start = time()

function myModel(MyFileName::String, lambada::Float64)
  n, l, cout, d, Amax, Amin, B = read_instance(MyFileName)

  # Create the model
  m = Model(CPLEX.Optimizer)

  ## Variables
  @variable(m, x[1:(n*l)], Bin)
  @variable(m, y[1:(n*l),1:(n*l)], Bin)

  ## Constraints
  @constraint(m, sum(cout[i]*x[i] for i in 1:(n*l)) <= B) #couts
  @constraint(m, sum(x[i] for i in 1:(n*l)) <= Amax) # aire max
  @constraint(m, sum(x[i] for i in 1:(n*l)) >= Amin) # aire min
  @constraint(m, [i in 1:(n*l), j in 1:(n*l)], y[i,j] <= x[i])
  @constraint(m, [i in 1:(n*l), j in 1:(n*l)], y[i,j] <= x[j])
  @constraint(m, [i in 1:(n*l)], sum(y[i,j] for j in 1:(n*l)) == x[i])
  @constraint(m, [i in 1:(n*l)], y[i,i] == 0)

  ## Objective
  @objective(m, Min, sum(d[i,j]*y[i,j] for i in 1:(n*l), j in 1:(n*l))-lambada*sum(x[i] for i in 1:(n*l)))

  #resolution
  optimize!(m)

  objective = JuMP.objective_value.(m)
  x_opt = JuMP.getvalue.( m[:x] )
  y_opt = JuMP.getvalue.( m[:y] )

  return objective, x_opt, y_opt
end

function Dinkelbach(MyFileName::String)
  n, l, cout, d, Amax, Amin, B = read_instance(MyFileName)
  lambada = 0.5 # step 1
  objective, x_opt, y_opt = myModel(MyFileName, lambada) # step 2 & 3
  while objective > 0 + 1e-5
    lambada = sum(d[i,j]*y_opt[i,j] for i in 1:(n*l), j in 1:(n*l)) / sum(x_opt[i] for i in 1:(n*l))
    objective, x_opt, y_opt = myModel(MyFileName, lambada)
  end
  println("#####################", lambada)
end

Dinkelbach("Min_fragmentation_ampl.dat")
