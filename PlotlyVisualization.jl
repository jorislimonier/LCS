module PlotlyVisualization

using PlotlyJS
include("Sequences.jl")

function average_lcs_length(moving_averages, seq_length)
    plot = Plot()
    trace = scatter(x=seq_length,y=moving_averages,mode="lines",)
    addtraces!(plot, trace)
    return plot
end

function plot_average_lengths(lcs_averages)
    plot = Plot()
    sorted_keys = sort(collect(keys(lcs_averages)))
    y = [lcs_averages[key] for key in sorted_keys]

    plot = Plot()
    addtraces!(plot, scatter(x=sorted_keys, y=y; name="average_length"))
    slope = Sequences.nbchar_slope(lcs_averages)
    addtraces!(plot, scatter(x=1:last(sorted_keys), y=[slope*x for x in 1:last(sorted_keys)], opacity=.8, name="slope $(round(slope, digits=3))"))
    return plot
end

# end module
end
