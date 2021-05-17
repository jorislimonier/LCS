module Visualization

using PlotlyJS
include("Sequences.jl")

function ma_lcs_length(moving_averages, seq_length)
    plot = Plot()
    trace = scatter(
        x=seq_length, 
        y=moving_averages, 
        mode="lines", 
    )
    addtraces!(plot, trace)
    relayout!(plot, Layout(
        title="LCS moving average over runs"),
        xaxis=attr(title="Number of runs"),
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
        yaxis=attr(title="LCS length"),
    )
    return plot
end

function lcs_length_distr(mult_lcs_lengths)
    plot = Plot()
    addtraces!(plot, histogram(x=mult_lcs_lengths, weights=3))
    return plot

end
# end module
end
