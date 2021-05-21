module Sequences

using StatsBase
using DataFrames
using Distributions
using Random
# Random.seed!(42)

mutable struct Sequence
    len::Int
    char::Array{Any}
end

"""
creates a sequence given
characters and a sequence length
""" 
function generate_sequence(seq::Sequence)
    sample(seq.char, seq.len)
end

"make table"
function lcs_table(X, Y)
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

"get the lcs after computing the table"
function lcs_from_table(X, Y, T)
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

"""returns the length of the lcs between random
sequences of length seq_length, having characters char"""
function get_lcs_length(seq_length, char)
    X = generate_sequence(Sequence(seq_length, char))
    Y = generate_sequence(Sequence(seq_length, char))    
    T = lcs_table(X, Y)
    lcs = lcs_from_table(X, Y, T)
    return length(lcs)
end

"get lcs length on `replicates` replicates"
function multiple_lcs_lengths(seq_length, replicates, nb_chars)
    lcs_results = [get_lcs_length(seq_length, collect(1:nb_chars)) for _ in 1:replicates]
    return Vector{Int}(lcs_results)
end

"""
Generate a normal distribution with mean
and standard deviation from mult_lcs_lengths
"""
function normal_distr_from(mult_lcs_lengths)
    σ  = StatsBase.std(mult_lcs_lengths)
    μ = mean(mult_lcs_lengths)
    replicates = length(mult_lcs_lengths)
    return [Int(round(length)) for length in rand(Normal(μ, σ), replicates)]
end

"""
computes the l1-norm between the empirical LCS lengths and 
a normal fitted curve, then normalizes for the number of replicates
"""
function normal_fitness(mult_lcs_lengths, normal_fit, replicates)
    min_length, max_length = extrema(vcat(mult_lcs_lengths, normal_fit))
    diff = [abs(count(==(length), normal_fit) - count(==(length), mult_lcs_lengths)) for length in min_length:max_length]
    return sum(diff) / replicates
end

"compute moving averages overs results"
function moving_averages(results)
    moving_averages = []
    for i in 1:length(results)
        append!(moving_averages, mean(results[1:i]))
    end
    return moving_averages
end

"returns for each sequence length in
`seq_lengths` the average lcs length"
function compare_lcs_averages(seq_lengths, replicates, nb_chars)
    return Dict(len => mean(multiple_lcs_lengths(len, replicates, nb_chars)) for len in seq_lengths)
end

"""gets slope of the length of LCS
as a function of sequence length"""
function nbchar_slope(lcs_averages)
    ratios = []
    for key in keys(lcs_averages)
        key == 0 && continue
        append!(ratios, lcs_averages[key] / key)
    end
    return mean(ratios)
end

# end module
end

