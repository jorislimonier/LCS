module GadflyPlots
using Gadfly

function plot_moving_averages(ma, seq_length)
    # if key in keys(ma)
        # Theme(point_size=5mm)
    pl = plot(
        y=ma,
        Guide.title("$seq_length"),
        Geom.line,
        # Geom.point,
        # size=[.7mm]
    )
    return pl
    # else
    #     println("\n/!\\ Key not found")
    # end

end

end