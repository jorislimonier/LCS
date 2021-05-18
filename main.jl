include("src/Sequences.jl")
include("src/Visualization.jl")

# using Random
# Random.seed!(42)

seq_length = 100
replicates = 2000
nb_chars = 2
mult_lcs_lengths = Sequences.multiple_lcs_lengths(seq_length, replicates, nb_chars)

# # ====== Plot Moving Averages ======
# moving_averages = Sequences.moving_averages(mult_lcs_lengths)
# Visualization.ma_lcs_length(moving_averages, seq_length)

# # ====== Compare LCS average lengths ======
# seq_lengths = 0:50:200
# lcs_av = Sequences.compare_lcs_averages(seq_lengths, replicates, nb_chars)
# plot_averages = Visualization.plot_average_lengths_distr(lcs_av)

# ====== Histogram of LCS lengths ======
normal_fit = Sequences.normal_distr_from(mult_lcs_lengths)
norm_plot = Visualization.lcs_length_distr(mult_lcs_lengths, normal_fit, replicates)

# ====== Compare LCS lengths distribution with Normal ======

nb_rep = 500
mult_lcs_lengths = Sequences.multiple_lcs_lengths(seq_length, nb_rep, nb_chars)
normal_fit = Sequences.normal_distr_from(mult_lcs_lengths)
Sequences.normal_fitness(mult_lcs_lengths, normal_fit, nb_rep)


replicates_values = vcat(collect(100:200:500), collect(750:250:2000))
nb_repetitions = 1

fig = Visualization.evaluate_normal_fitness(replicates_values, seq_length, nb_chars, nb_repetitions)
savefig(fig, "fig/testfig.png")