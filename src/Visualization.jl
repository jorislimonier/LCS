module Visualization

using Random
using PlotlyJS
using Statistics
include("Sequences.jl")

"""
returns a scatter plot of the
moving average over replicates
"""
function ma_lcs_length(moving_averages, seq_length, is_savefig=false)
    plot = Plot()
    trace = scatter(
        x=seq_length, 
        y=moving_averages, 
        mode="lines", 
    )
    addtraces!(plot, trace)
    nb_replicates = length(moving_averages)
    relayout!(plot, Layout(
        title="LCS moving average over $(nb_replicates) replicates"),
        xaxis=attr(title="Number of replicates"),
        yaxis=attr(title="Moving average"),
    )
    if is_savefig
        title = "fig/ma_lcs_length/length$(seq_length)_replicates$(nb_replicates).png"
        savefig(plot, title)
    end
    return plot
end

function plot_average_lengths_distr(lcs_averages, is_savefig=false)
    plot = Plot()
    sorted_keys = sort(collect(keys(lcs_averages)))
    y = [lcs_averages[key] for key in sorted_keys]

    plot = Plot()
    addtraces!(plot, scatter(x=sorted_keys, y=y; name="average_length"))
    slope = Sequences.nbchar_slope(lcs_averages)
    line_fit = scatter(
        x=1:last(sorted_keys), 
        y=[slope * x for x in 1:last(sorted_keys)], 
        opacity=.8, 
        name="slope $(round(slope, digits=3))"
    )
    addtraces!(plot, line_fit)
    relayout!(plot, Layout(
        title="Average LCS length comparison over multiple sequence lengths"),
        xaxis=attr(title="Sequence length"),
        yaxis=attr(title="Average LCS length"),
    )
    if is_savefig
        seq_lengths = sort(collect(keys(lcs_averages)))
        title = "fig/average_length_comparison/$(join(seq_lengths, "_")).png"
        savefig(plot, title)
    end
    return plot
end

function lcs_length_distr(mult_lcs_lengths, normal_fit, seq_length, is_savefig=false)
    # Random.seed!(42)
    nb_replicates = length(mult_lcs_lengths)
    seq_length_guess = round(mean(mult_lcs_lengths) / 79, digits=1) * 100
    seq_length_guess = round(Int, (seq_length_guess))

    plot = Plot()
    hist = histogram(
        x=mult_lcs_lengths,
        opacity=.75,
        name="Empirical occurences",
    )
    addtraces!(plot, hist)
    hist_normal = histogram(
        x=normal_fit,
        opacity=0.5,
        name="Normal fit",
    )
    addtraces!(plot, hist_normal)
    layout = Layout(
        title="Distribution of LCS length for $nb_replicates replicates with length $seq_length_guess",
        xaxis_title="LCS length",
        yaxis_title="Number of occurences",
        barmode="overlay"
    )
    relayout!(plot, layout)
    if is_savefig
        title = "fig/lcs_length_distribution/length_$(seq_length_guess)_rep$(nb_replicates).png"
        savefig(plot, title)
    end
    return plot
end

"""
Plots the difference between the normal samples and
the empirical samples as proportion of the total number of replicates
"""
function evaluate_normal_fitness(replicates_values, seq_length, nb_chars, nb_repetitions, is_savefig=false)
    plot = Plot()
    fitnesses = []
    for nb_rep in collect(replicates_values)
        nb_rep_fitness = []
        for i in 1:nb_repetitions
            mult_lcs_lengths = Sequences.multiple_lcs_lengths(seq_length, nb_rep, nb_chars)
            normal_fit = Sequences.normal_distr_from(mult_lcs_lengths)
            append!(nb_rep_fitness, Sequences.normal_fitness(mult_lcs_lengths, normal_fit, nb_rep))
        end
        append!(fitnesses, mean(nb_rep_fitness))
    end
    scat = scatter(
        x=replicates_values,
        y=fitnesses,
    )
    addtraces!(plot, scat)
    layout = Layout(
        title="Mean absolute difference to Normal distribution (length $seq_length)",
        xaxis_title="Number of replicates",
        yaxis_title="Mean absolute error",
        
    )
    relayout!(plot, layout)
    if is_savefig
        title = "fig/diff_to_normal/length$(seq_length)_replicates$(join(replicates_values, "_"))_repetitions$(nb_repetitions).png"
        savefig(plot, title)
    end
    return plot
end
# end module
end
