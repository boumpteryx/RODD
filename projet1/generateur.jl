# generateur d'Instances pour la RODD


n = 10
P = 6



# Ouvrir le fichier "output.txt" dans lequel on pourra écrire
fout = open("outputn10P6.txt", "w")
println(fout, "title")

println(fout, "n = " * string(n))
println(fout, "P = " * string(P))

for i in 1:n
  for j in 1:n
    println(fout, string(i) * " " * string(j) * " " * string(rand(1:10)))
  end
end

for k in 1:P
  for i in 1:n
    for j in 1:n
      if rand(1:10) <= 9
        println(fout, string(k) * " " * string(i) * " " * string(j) * " " * string((rand(Float64,1)/2)[1]))
      end
    end
  end
end

close(fout)
