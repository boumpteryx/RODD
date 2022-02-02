# generateur d'Instances pour la RODD


n = 10
m = 10



# Ouvrir le fichier "output.txt" dans lequel on pourra écrire
fout = open("outputn10m10.txt", "w")
println(fout, "title")

println(fout, "n = " * string(n))
println(fout, "m = " * string(m))

for i in 1:n
  myLine = ""
  for j in 1:(m-1)
    myLine = myLine * string(rand(1:10)) * " "
  end
  myLine = myLine * string(rand(1:10))
  println(fout, myLine)
end

close(fout)
