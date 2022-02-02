# parser

function read_instance(MyFileName::String)
  path = "./" * MyFileName
  # Si le fichier path existe
  if isfile(path)
    # L’ouvrir
    myFile = open(path)
    readline(myFile)

    n = parse(Int64, split(readline(myFile), " ")[3])
    P = parse(Int64, split(readline(myFile), " ")[3])

    cout = Array{Int64,2}(ones(n,n)) # on met a zero pour l'instant
    for i in 1:n
      for j in 1:n
        line =  split(readline(myFile), " ")
        cout[parse(Int64,line[1]),parse(Int64,line[2])] = parse(Int64,line[3])
      end
    end

    alpha1 = Array{Float64,1}(zeros(P))
    for i in 1:P
      alpha1[i] = 0.5 # donnees du poly
    end
    alpha2 = Array{Float64,1}(zeros(P))
    for i in 1:3
      alpha2[i] = 0.9 # donnees du poly
    end
    for i in 4:6
      alpha2[i] = 0.5 # donnees du poly
    end
    alpha3 = Array{Float64,1}(zeros(P))
    for i in 1:3
      alpha3[i] = 0.5 # donnees du poly
    end
    for i in 4:6
      alpha3[i] = 0.9 # donnees du poly
    end
    alpha4 = Array{Float64,1}(zeros(P))
    for i in 1:3
      alpha4[i] = 0.8 # donnees du poly
    end
    for i in 4:6
      alpha4[i] = 0.6 # donnees du poly
    end

    indice_danger = Array{Float64,1}(zeros(P))
    for i in 1:3
      indice_danger[i] = 1
    end

    Survie = Array{Float64,3}(zeros(P,n,n))
    data = readlines(myFile)
		for datum in data
      line = split(datum, " ")
      Survie[parse(Int64,line[1]),parse(Int64,line[2]),parse(Int64,line[3])] = parse(Float64,line[4])
    end
    return n, P, alpha4, Survie, indice_danger, cout
  end
end
