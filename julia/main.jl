include("Sequences.jl")
include("PlotlyVisualization.jl")
include("GadflyPlots.jl")

seq_length = 400
results = Sequences.multiple_lcs_lengths(seq_length, 30)

## plot moving averages
moving_averages = Sequences.moving_averages(results)
PlotlyJS_plots.average_lcs_length(moving_averages, seq_length)

## compare lcs averages
plot_averages = PlotlyVisualization.plot_average_lengths(000:200:2000, 2)
