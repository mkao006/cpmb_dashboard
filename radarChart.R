########################################################################
## Title: Prototype of the radar chart
## Date: 2013-10-03
########################################################################

library(fmsb)

sim.df = data.frame(
    Year = c(2010, 2000, 2000, 2005, 2010),
    OO1 = c(100, 0, runif(3, 0, 100)),
    OO2 = c(100, 0, runif(3, 0, 100)),
    OO3 = c(100, 0, runif(3, 0, 100)),
    OO4 = c(100, 0, runif(3, 0, 100))
    )


radarchart(sim.df[, c("OO1", "OO2", "OO3", "OO4")],
           axistype = 1, plwd = c(0.5, 1, 0.5), 
           pcol = c(1, 0, 1), centerzero=TRUE, 
           pfcol = c(rgb(0, 0, 0, alpha = 0),
               topo.colors(10, alpha = 0.3)[3],
               rgb(0, 0, 0, alpha = 0)),
           pty = c(15, 32, 16), plty = c(1, 1, 1),
           seg = 4, caxislabels = c("0%", "25%", "25%", "75%", "100%"),
           title = "Protoype type of the Global Radar Chart")
