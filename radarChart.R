########################################################################
## Title: Prototype of the radar chart
## Date: 2013-10-03
########################################################################

library(fmsb)

sim.df = data.frame(
    Year = c(0, 2000, 2000, 2005, 2005),
    OO1 = c(100, 0, runif(3, 0, 100)),
    OO2 = c(100, 0, runif(3, 0, 100)),
    OO3 = c(100, 0, runif(3, 0, 100)),
    OO4 = c(100, 0, runif(3, 0, 100))
    )
radarchart(sim.df[, c("OO1", "OO2", "OO3", "OO4")],
           axistype = 1, plwd = 2,
           pcol = c(1, 0, 1), centerzero=TRUE,
           ## pfcol = c(rgb(0, 0, 0, alpha = 0),
           ##     topo.colors(10, alpha = 0.3)[3],
           ##     rgb(0, 0, 0, alpha = 0)),
           pty = c(15, 32, 16), plty = c(2, 1, 1),
           seg = 4,
           ## caxislabels = c("0%", "25%", "25%", "75%", "100%"),
           caxislabels = c("0%", "1", "2", "3", "4"),
           title = "Protoype type of the Global Radar Chart")
legend("topleft", legend = c("2000", "2005"), bty = "n",
       lty = c(2, 1), pch = c(15, 16))



sim.df = data.frame(
    Year = c(0, 2000, 2000, 2005, 2005),
    `Policies,\n programmes and legal frameworks` =
    c(100, 0, runif(3, 0, 100)),
    `Evidence based \n decision making` =
    c(100, 0, runif(3, 0, 100)),
    `Coordination \n mechanisms and \n partnership` =
    c(100, 0, runif(3, 0, 100)),
    `Resources, \n knowledge and \n good governance` =
    c(100, 0, runif(3, 0, 100)), check.names = FALSE,
    )
pdf(file = "testRadar.pdf", width = 15, height = 15)
radarchart(sim.df[, -1],
           axistype = 1, plwd = 2,
           pcol = c(1, 0, 1), centerzero=TRUE,
           ## pfcol = c(rgb(0, 0, 0, alpha = 0),
           ##     topo.colors(10, alpha = 0.3)[3],
           ##     rgb(0, 0, 0, alpha = 0)),
           pty = c(15, 32, 16), plty = c(2, 1, 1),
           seg = 4,
           ## caxislabels = c("0%", "25%", "25%", "75%", "100%"),
           caxislabels = c("0%", "1", "2", "3", "4"),
           ## title = "Protoype type of the Global Radar Chart"
           title = ""
           )
legend(1, 1, legend = c("2000", "2005"), bty = "n",
       lty = c(2, 1), pch = c(15, 16))
graphics.off()
