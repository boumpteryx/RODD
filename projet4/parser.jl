# parser

function read_instance(MyFileName::String)
  path = "./" * MyFileName
  # Si le fichier path existe
  if isfile(path)
    # L’ouvrir
    myFile = open(path)

    P = parse(Int64, split(readline(myFile), " ")[3])
    m = parse(Int64, split(readline(myFile), " ")[3])
    n = parse(Int64, split(readline(myFile), " ")[3])
    w1 = parse(Int64, split(readline(myFile), " ")[3])
    w2 = parse(Int64, split(readline(myFile), " ")[3])
    L = parse(Int64, split(readline(myFile), " ")[3])
    g = parse(Float64, split(readline(myFile), " ")[3])

    readline(myFile)

    t = Array{Int64,2}(ones(n,m)) # on met a zero pour l'instant
    for i in 1:n
    line =  split(readline(myFile), " ")
      for j in 1:m
      t[i,j] = parse(Int64,line[j + 1])
      end
    end

    return P, m, n, w1, w2, L, g, t
  end
end
