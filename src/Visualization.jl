module Visualization

using PlotlyJS
include("Sequences.jl")

"""
returns a scatter plot of the
moving average over replicates
"""
function ma_lcs_length(moving_averages, seq_length)
    plot = Plot()
    trace = scatter(
        x=seq_length, 
        y=moving_averages, 
        mode="lines", 
    )
    addtraces!(plot, trace)
    relayout!(plot, Layout(
        title="LCS moving average over replicates"),
        xaxis=attr(title="Number of replicates"),
        yaxis=attr(title="Moving average"),
    )
    return plot
end

function plot_average_lengths(lcs_averages)
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
    return plot
end

function lcs_length_distr(mult_lcs_lengths)
    plot = Plot()
    hist = histogram(
        x=mult_lcs_lengths,
        opacity=.75,
        name="Empirical occurences",
    )
    addtraces!(plot, hist)
    hist_normal = histogram(
        x=Sequences.normal_distr_from(mult_lcs_lengths),
        opacity=0.5,
        name="Normal fit",
    )
    addtraces!(plot, hist_normal)
    layout = Layout(
        title="Average LCS length comparison over multiple sequence lengths",
        xaxis_title="LCS length",
        yaxis_title="Number of occurences",
        barmode="overlay"
    )
    relayout!(plot, layout)
    
    return plot

end
# end module
end
