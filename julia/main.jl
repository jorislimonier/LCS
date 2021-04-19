include("Sequences.jl")
include("PlotlyVisualization.jl")
include("GadflyPlots.jl")

seq_length = 500
runs = 100
nb_chars = 2
results = Sequences.multiple_lcs_lengths(seq_length, runs, nb_chars)

# plot moving averages
moving_averages = Sequences.moving_averages(results)
PlotlyVisualization.average_lcs_length(moving_averages, seq_length)

# compare lcs averages
plot_averages = PlotlyVisualization.plot_average_lengths(0:100:1000, 2, nb_chars)



