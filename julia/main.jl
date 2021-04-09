include("Sequences.jl")
include("PlotlyJS.jl")
include("Gadfly.jl")


# plots
## plot all given averages
res = Sequences.lcs_average_lengths_comparison(100:100:500, 100)
PlotlyJS.average_lcs_length(res)
