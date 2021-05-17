include("src/Sequences.jl")
include("src/Visualization.jl")

seq_length = 100
seq_lengths = 0:50:200
runs = 100
nb_chars = 2
mult_lcs_lengths = Sequences.multiple_lcs_lengths(seq_length, runs, nb_chars)
lcs_av = Sequences.compare_lcs_averages(seq_lengths, runs, nb_chars)

# plot moving averages
moving_averages = Sequences.moving_averages(mult_lcs_lengths)
# Visualization.ma_lcs_length(moving_averages, seq_length)

# compare lcs averages
# plot_averages = Visualization.plot_average_lengths(lcs_av)

norm_plot = Visualization.lcs_length_distr(mult_lcs_lengths)

