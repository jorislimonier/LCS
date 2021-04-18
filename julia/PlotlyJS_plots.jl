module PlotlyJS_plots

using PlotlyJS, DataFrames, CSV, Dates, Statistics


function average_lcs_length(moving_averages, seq_length)
    plot = Plot()
    trace = scatter(
        x=seq_length,
        y=moving_averages,
        mode="lines",
    )
    addtraces!(plot, trace)
    return plot
end

end