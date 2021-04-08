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

function get_lcs_length(seq_length, char)
    # returns the length of the lcs between random sequences of length seq_length, having characters char
    X = generate_sequence(SeqMod.Sequence(seq_length, char))
    Y = generate_sequence(SeqMod.Sequence(seq_length, char))    
    T = lcs_table(X, Y)
    lcs = lcs_from_table(T)
    return length(lcs)
end

function append_lcs_length(results_dict, seq_length, char)
    if  !(seq_length in keys(results_dict))
        results_dict[seq_length] = zeros(0)
    end
    append!(results_dict[seq_length], get_lcs_length(seq_length, char))
end

lcs_results = Dict()
for l in 20:10:50
    typeof("type of l is $l")
    for _ in 1:1000
        append_lcs_length(lcs_results, l, [0, 1])
    end
end
lcs_results

