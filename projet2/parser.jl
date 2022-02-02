# parser

function read_instance(MyFileName::String)
  path = "./" * MyFileName
  # Si le fichier path existe
  if isfile(path)
    # L’ouvrir
    myFile = open(path)
    Amax = 35
    Amin = 30
    B = 92
    readline(myFile)

    n = parse(Int64, split(readline(myFile), " ")[3])
    m = parse(Int64, split(readline(myFile), " ")[3])

    cout = Array{Int64,1}(zeros(0)) # on met a zero pour l'instant
    for i in 1:n
      line = parse.(Int64, split(readline(myFile), " "))
      for elem in line
        append!(cout, elem)
      end
    end

    d = Array{Float64,2}(zeros(n*m,n*m)) # on met a zero pour l'instant
    for i in 1:n
      for j in 1:m
        for k in 1:n
          for l in 1:m
            n1 = m*(i-1) + j
            n2 = m*(k-1) + l
            if n1 != n2
              d[n1,n2] = sqrt(((i) - (k))^2 + ((j) - (l))^2)
            end
          end
        end
      end
    end
    return n, m, cout, d, Amax, Amin, B
  end
end
