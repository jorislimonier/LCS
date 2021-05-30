include("src/Sequences.jl")
include("src/Visualization.jl")

# ============ Slideshow ============
# nb_chars = 2
# s = Sequences.Sequence(256, ["A", "B"])
# # X = Sequences.generate_sequence(s)
# # Y = Sequences.generate_sequence(s)
# X = ["A", "A", "B", "A", "B"]
# Y = ["A", "B", "A", "B", "B"]
# T = Sequences.lcs_table(X, Y)
# LCS = Sequences.lcs_from_table(Y, X, T)
# X
# Y
# T

# ============ Main code ============
seq_length = 100
replicates = 1000
nb_chars = 2
mult_lcs_lengths = Sequences.multiple_lcs_lengths(seq_length, replicates, nb_chars)

# ====== Plot Moving Averages ======
moving_averages = Sequences.moving_averages(mult_lcs_lengths)
Visualization.ma_lcs_length(moving_averages, seq_length, true)

# ====== Compare LCS average lengths ======
seq_lengths = vcat(collect(100:100:900), collect(1000:200:1999), collect(2000:1000:5000))
seq_lengths = vcat(collect(100:101))
lcs_av = Sequences.compare_lcs_averages(seq_lengths, replicates, nb_chars)
plot_averages = Visualization.plot_average_lengths_distr(lcs_av, true)

# ====== Histogram of LCS lengths ======
normal_fit = Sequences.normal_distr_from(mult_lcs_lengths)
norm_plot = Visualization.lcs_length_distr(mult_lcs_lengths, normal_fit, seq_length, true)

# ====== Compare LCS lengths distribution with Normal ======
replicates_values = vcat(collect(100:100:900), collect(1000:200:1999), collect(2000:1000:5000))
nb_repetitions = 100
fig = Visualization.evaluate_normal_fitness(replicates_values, seq_length, nb_chars, nb_repetitions, true)
join(replicates_values, "_")