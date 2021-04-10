module Gadfly_plots
using Gadfly

function plot_moving_averages(ma, key)
    if key in keys(ma)
        # Theme(point_size=5mm)
        pl = plot(
            y=ma[key],
            Geom.line,
            Geom.point,
            size=[.7mm]
        )
        return pl
    else
        println("\n/!\\ Key not found")
    end

end










end