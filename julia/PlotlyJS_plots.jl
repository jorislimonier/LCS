module PlotlyJS

using PlotlyJS, DataFrames, CSV, Dates, Statistics


function average_lcs_length(res)
    plot = Plot()
    sorted_keys = sort([collect(res)[i][1] for i in 1:length(res)])
    for key in sorted_keys
        println(key)
        trace = scatter(
            x=[key],
            y=[mean(res[key])],
            mode="markers",
            name=key
        )
        addtraces!(plot, trace)
    end
    return plot
end

end