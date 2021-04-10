include("Sequences.jl")
include("PlotlyJS_plots.jl")
include("Gadfly_plots.jl")


res = Sequences.lcs_average_lengths_comparison(10000:100:10000, 50)

# plots
## plot all given averages

moving_averages = Sequences.compute_moving_averages(res)
Gadfly_plots.plot_moving_averages(moving_averages, 10000)


