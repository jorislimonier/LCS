include("Sequences.jl")
include("PlotlyJS_plots.jl")
include("Gadfly_plots.jl")

seq_length = 200

res = Sequences.lcs_average_lengths_comparison(seq_length, 300)

# plots
## plot all given averages
moving_averages = Sequences.compute_moving_averages(res)
Gadfly_plots.plot_moving_averages(moving_averages, seq_length)
