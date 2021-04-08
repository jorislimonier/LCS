module SeqMod
using Random
Random.seed!(42)
mutable struct Sequence
    len::Int
    char::Array{Any}
end
end

