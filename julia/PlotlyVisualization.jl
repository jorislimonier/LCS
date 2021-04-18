module PlotlyVisualization

using PlotlyJS, DataFrames, CSV, Dates, Statistics
include("Sequences.jl")

function average_lcs_length(moving_averages, seq_length)
    plot = Plot()
    trace = scatter(x=seq_length,y=moving_averages,mode="lines",)
    addtraces!(plot, trace)
    return plot
end

function plot_average_lengths(seq_lengths, runs)
    results = Sequences.compare_lcs_averages(seq_lengths, runs)
    plot = Plot()
    sorted_keys = sort(collect(keys(results)))
    y = [results[key] for key in sorted_keys]

    plot = Plot()
    addtraces!(plot, scatter(x=sorted_keys, y=y; name="average_length"))
    addtraces!(plot, scatter(x=1:last(sorted_keys), y=[4*x / 5 for x in 1:last(sorted_keys)], opacity=.8, name="y = 4x/5"))
    return plot
end

# end module
end