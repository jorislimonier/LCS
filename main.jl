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
Sequences.normal_fitness(mult_lcs_lengths, normal_fit, nb_rep)

range = 100:100:500

using PlotlyJS
function evaluate_normal_fitness(range, seq_length, nb_chars)
    plot = Plot()
    nb_replicates = collect(range)
    fitnesses = []
    for nb_rep in nb_replicates
        nb_rep_fitness = []
        for i in 1:10
            mult_lcs_lengths = Sequences.multiple_lcs_lengths(seq_length, nb_rep, nb_chars)
            normal_fit = Sequences.normal_distr_from(mult_lcs_lengths)
            append!(nb_rep_fitness, Sequences.normal_fitness(mult_lcs_lengths, normal_fit, nb_rep))
        end
        append!(fitnesses, mean(nb_rep_fitness))
    end
    scat = scatter(
        x=nb_replicates,
        y=fitnesses,
    )
    addtraces!(plot, scat)
    return plot
end

evaluate_normal_fitness(vcat(collect(100:100:500), collect(1000:500:2000)), seq_length, nb_chars)


vcat(collect(100:100:500), collect(1000:500:2000))

using Statistics
mean([1, 2])