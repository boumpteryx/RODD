using JuMP
using CPLEX

include("parser.jl")

start = time()

function Mymodel(MyFileName::String)
  P, Nm, Nf, C, G, A, T, init, y = read_instance(MyFileName)
  nbAllele = A * G

  # Create the model
  m = Model(CPLEX.Optimizer)

  ## Variables
  @variable(m, x[1:P] >= 0, Int)
  @variable(m, t[1:nbAllele] >= 0)
  @variable(m, z[1:nbAllele] >= 0)

  ## Constraints
  @constraint(m, sum(x[i] for i in 1:Nm) = P)
  @constraint(m, sum(x[i] for i in Nm+1:P) = P)
  @constraint(m, [j in 1:nbAllele], z[j] >= t[j] - sum(x[i] for i in 1:P if y[i,j] == 2))
  

  ## Objective
  @objective(m, Min, sum(z[j] j in 1:nbAllele))

  #resolution
  optimize!(m)

  # solution_summary(m, verbose=true)
  z_vals = JuMP.getvalue.( m[:z] )
  # println(z_vals)

end

Mymodel("DivGenetique_ampl.dat")
