using JuMP
using CPLEX

include("parser.jl")

start = time()

function Mymodel(MyFileName::String)
  n, P, alpha, Survie, indice_danger, cout = read_instance(MyFileName)

  # Create the model
  m = Model(CPLEX.Optimizer)

  ## Variables
  @variable(m, x[1:n,1:n], Bin)
  @variable(m, y[1:n,1:n], Bin)
  @variable(m, z[1:P,1:n,1:n] <= 0)

  ## Constraints
  @constraint(m, [k in 1:P, i in 1:n, j in 1:n ; indice_danger[k] == 0], z[k,i,j] >= x[i,j]*log(1-Survie[k,i,j]))
  @constraint(m, [k in 1:P, i in 1:n, j in 1:n ; indice_danger[k] == 1], z[k,i,j] >= y[i,j]*log(1-Survie[k,i,j]))
  @constraint(m, [k in 1:P], sum(z[k,i,j] for i in 1:n, j in 1:n) <= log(1-alpha[k]))
  @constraint(m, [i in 1:n, j in 1:n ; i == 1 || j == 1 || i == n || j == n], y[i] <= 0)    # bordure => y = 0
  @constraint(m, [i in 2:n-1, j in 2:n-1], y[i,j] <= x[i,j])
  @constraint(m, [i in 2:n-1, j in 2:n-1], y[i,j] <= x[i-1,j])
  @constraint(m, [i in 2:n-1, j in 2:n-1], y[i,j] <= x[i+1,j])
  @constraint(m, [i in 2:n-1, j in 2:n-1], y[i,j] <= x[i,j-1])
  @constraint(m, [i in 2:n-1, j in 2:n-1], y[i,j] <= x[i,j+1])
  @constraint(m, [i in 2:n-1, j in 2:n-1], y[i,j] <= x[i-1,j-1])
  @constraint(m, [i in 2:n-1, j in 2:n-1], y[i,j] <= x[i-1,j+1])
  @constraint(m, [i in 2:n-1, j in 2:n-1], y[i,j] <= x[i+1,j-1])
  @constraint(m, [i in 2:n-1, j in 2:n-1], y[i,j] <= x[i+1,j+1])

  ## Objective
  @objective(m, Min, sum(x[i,j]*cout[i,j] for i in 1:n, j in 1:n))

  #resolution
  optimize!(m)

  # solution_summary(m, verbose=true)
  z_vals = JuMP.getvalue.( m[:z] )
  # println(z_vals)

  for k in 1:P
    println(-(exp(sum(z_vals[k,i,j] for i in 1:n, j in 1:n))-1))
  end

  # println(-(exp(sum(z[k,i,j] for i in 1:n, j in 1:n))-1))

end

Mymodel("outputn10P6.txt")
