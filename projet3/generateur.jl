# generateur d'Instances pour la RODD projet 3


N = 8
Nm = 4
Nf = 4
C = 1
G = 5
A = 2
T = 50
init = 0.001



# Ouvrir le fichier "output.txt" dans lequel on pourra écrire
fout = open("output.txt", "w")

println(fout, "title")
println(fout, "title")
println(fout, "title")
println(fout, "title")

println(fout, "N = " * string(N))
println(fout, "Nm = " * string(Nm))
println(fout, "Nf = " * string(Nf))
println(fout, "C = " * string(C))
println(fout, "G = " * string(G))
println(fout, "A = " * string(A))
println(fout, "T = " * string(T))
println(fout, "init = " * string(init))

for i in 1:N
  for j in 1:G
    myLine = string(i) * " " * string(1) * " " * string(j) * " " * string(1) * " " * string(rand(1:A))
    println(fout, myLine)
    myLine = string(i) * " " * string(1) * " " * string(j) * " " * string(2) * " " * string(rand(1:A))
    println(fout, myLine)
  end
end

close(fout)
