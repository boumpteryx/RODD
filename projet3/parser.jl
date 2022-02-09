# parser

function read_instance(MyFileName::String)
  path = "./" * MyFileName
  # Si le fichier path existe
  if isfile(path)
    # L’ouvrir
    myFile = open(path)
    readline(myFile)
    readline(myFile)
    readline(myFile)
    readline(myFile)

    N = parse(Int64, split(readline(myFile), " ")[3])
    Nm = parse(Int64, split(readline(myFile), " ")[3])
    Nf = parse(Int64, split(readline(myFile), " ")[3])
    C = parse(Int64, split(readline(myFile), " ")[3])
    G = parse(Int64, split(readline(myFile), " ")[3])
    A = parse(Int64, split(readline(myFile), " ")[3])
    T = parse(Int64, split(readline(myFile), " ")[3])
    init = parse(Float64, split(readline(myFile), " ")[3])

    y = Array{Int64,2}(zeros(N,A*G)) # on met a zero pour l'instant
    data = readlines(myFile)
		for datum in data
      line = split(datum, " ")
      allele = (parse(Int64,line[3]) - 1) * A + parse(Int64,line[5])
      y[parse(Int64,line[1]),allele] = y[parse(Int64,line[1]),allele] + 1
    end

    return N, Nm, Nf, C, G, A, T, init, y
  end
end
