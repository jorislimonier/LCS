include("src/Sequences.jl")
include("src/Visualization.jl")

seq_length = 100
seq_lengths = 0:50:200
replicates = 200
nb_chars = 2
mult_lcs_lengths = Sequences.multiple_lcs_lengths(seq_length, replicates, nb_chars)

# ====== Plot Moving Averages ======
moving_averages = Sequences.moving_averages(mult_lcs_lengths)
Visualization.ma_lcs_length(moving_averages, seq_length)

# ====== Compare LCS average lengths ======
lcs_av = Sequences.compare_lcs_averages(seq_lengths, replicates, nb_chars)
plot_averages = Visualization.plot_average_lengths(lcs_av)

# ====== Histogram of LCS lengths ======
norm_plot = Visualization.lcs_length_distr(mult_lcs_lengths, replicates)

# ====== Compare LCS lengths distribution with Normal ======
Sequences.normal_distr_from(mult_lcs_lengths)
