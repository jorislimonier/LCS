include("Sequences.jl")
include("PlotlyVisualization.jl")
include("GadflyPlots.jl")

seq_length = 500
runs = 100
nb_chars = 3
results = Sequences.multiple_lcs_lengths(seq_length, runs, nb_chars)

# plot moving averages
moving_averages = Sequences.moving_averages(results)
PlotlyVisualization.average_lcs_length(moving_averages, seq_length)

# compare lcs averages
plot_averages = PlotlyVisualization.plot_average_lengths(0:100:1000, 2, nb_chars)


using DataFrames, PlotlyJS, Statistics

lcs_averages = Sequences.compare_lcs_averages(000:1000:5000, 3, nb_chars)
sorted_seq_lengths = sort(collect(keys(lcs_averages)))
sorted_lcs_averages = [lcs_averages[k] for k in sorted_seq_lengths]

df = DataFrame(seq_lengths=sorted_seq_lengths, lcs_averages=sorted_lcs_averages)

df[:,:ratio] = df[:, 2] ./ df[:, 1]
df[1, :ratio] = 0.
df
slope = mean(df[2:end, :ratio])
plot = Plot()
addtraces!(plot, scatter(x=df[:,"seq_lengths"], y=df[:,"lcs_averages"]))
x = 0:5000
addtraces!(plot, scatter(x=x, y=slope .* x))

plot