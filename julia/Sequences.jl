module Sequences
using Random
# Random.seed!(42)
mutable struct Sequence
    len::Int
    char::Array{Any}
end

using Random
using StatsBase
using DataFrames
using Plotly

function generate_sequence(seq::Sequence)
    # creates a sequence given 
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

function lcs_from_table(X, Y, T)
    # get the lcs after computing the table
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
    """returns the length of the lcs between random
    sequences of length seq_length, having characters char"""
    X = generate_sequence(Sequence(seq_length, char))
    Y = generate_sequence(Sequence(seq_length, char))    
    T = lcs_table(X, Y)
    lcs = lcs_from_table(X, Y, T)
    return length(lcs)
end

# function append_lcs_length(results_dict, seq_length, char)
#     # creates new key in results_dict if necessary, then appends lcs results
#     if  !(seq_length in keys(results_dict))
#         results_dict[seq_length] = zeros(0)
#     end
#     append!(results_dict[seq_length], get_lcs_length(seq_length, char))
# end

function lcs_average_lengths_comparison(seq_length, repeats)
    # get lcs length on repeats runs
    lcs_results = []
    for _ in 1:repeats
        append!(lcs_results, get_lcs_length(seq_length, [0, 1]))
    end
    return lcs_results
end

function compute_moving_averages(results)
    # compute moving averages
    # sorted_keys = sort([collect(results)[i][1] for i in 1:length(results)])
    moving_averages = []
    # for key in sorted_keys
    # moving_averages[key] = []
    for i in 1:length(results)
        append!(moving_averages, mean(results[1:i]))
    end
    # end
    return moving_averages
end

end

