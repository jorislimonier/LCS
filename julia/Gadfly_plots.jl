module Gadfly_plots
using Gadfly


function plot_moving_averages(ma)
    pl = plot()
    for key in keys(ma)
        println(ma[key])
        break
    end


end



# plot(x=rand(10), y=rand(10), Geom.point, Geom.line)







end