# generateur d'Instances pour la RODD projet 4


P = 1
m = 15
n = 15
w1 = 1
w2 = 5
L = 3
g = 1.26157



# Ouvrir le fichier "output.txt" dans lequel on pourra écrire
fout = open("output30.txt", "w")

println(fout, "P = " * string(P))
println(fout, "m = " * string(m))
println(fout, "n = " * string(n))
println(fout, "w1 = " * string(w1))
println(fout, "w2 = " * string(w2))
println(fout, "L = " * string(L))
println(fout, "g = " * string(g))
println(fout, "title")

for i in 1:n
  myLine = string(i)
  for j in 1:(m)
    myLine = myLine * " " * string(rand(70:100))
  end
  println(fout, myLine)
end

close(fout)
