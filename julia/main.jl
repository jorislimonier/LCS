include("Sequence.jl")
using .SeqMod
using Random
using StatsBase
using DataFrames

function generate_sequence(seq::SeqMod.Sequence)
    sample(seq.char, seq.len)
end

function lcs_table(X, Y)
    # make table
    m = length(X)
    n = length(Y)
    T = zeros(Int, m + 1, n + 1)
    T[:] .= 999
    for i in 1:m + 1
        for j in 1:n + 1
            if i == 1 || j == 1
                T[i, j] = 0
            elseif X[i - 1] == Y[j - 1]
                T[i, j] = T[i - 1, j - 1] + 1
            else
                T[i, j] = maximum([T[i - 1, j], T[i, j - 1]])
            end
        end
    end
    return T
end

function lcs_from_table(T)
    m = size(T)[1]
    n = size(T)[2]

    index = T[m, n]
    lcs = Any[]

    i, j = m, n
    while i > 1 && j > 1
        if X[i - 1] == Y[j - 1]
            prepend!(lcs, [X[i - 1]])
            j -= 1
            i -= 1
        elseif T[i - 1, j] > T[i, j - 1]
                i -= 1
            else
                j -= 1
        end
    end
    return lcs
end

len = 10
char = [0, 1]
X = generate_sequence(SeqMod.Sequence(len, char))
Y = generate_sequence(SeqMod.Sequence(len, char))
println("  X: ", X)
println("  Y: ", Y)
T = lcs_table(X, Y)
display(T)
lcs = println(lcs_from_table(T))
