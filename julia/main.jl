include("Sequences.jl")
include("PlotlyJS.jl")
include("Gadfly.jl")


# plots
## plot all given averages
res = Sequences.lcs_average_lengths_comparison(100:100:500, 100)
PlotlyJS.average_lcs_length(res)

# continue with moving averages
sorted_keys = sort([collect(res)[i][1] for i in 1:length(res)])
moving_averages = Dict()
for key in sorted_keys
    all_lengths = res[key]
    for i in 1:length(all_lengths)
        println(len)
    end
end

