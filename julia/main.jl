include("Sequences.jl")
include("PlotlyJS_plots.jl")
include("Gadfly_plots.jl")


# plots
## plot all given averages
res = Sequences.lcs_average_lengths_comparison(100:100:300, 100)

moving_averages = Sequences.compute_moving_averages(res)
Gadfly_plots.plot_moving_averages(moving_averages, 200)
