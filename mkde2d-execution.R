# Script reads file containing data and parameters that had been exported from SEG (data2d.rds),
# constructs 2D home range and writes results (mkde.obj.rds)

library(mkde)
data <- readRDS("data2d.rds")
mv.dat <- initializeMovementData(data$t, data$x, data$y, sig2obs = data$sig2obs, t.max = data$t.max)
mkde.obj <- initializeMKDE2D(data$xmin, data$cell.sz, data$nx, data$ymin, data$cell.sz, data$ny)
dens.res <- initializeDensity(mkde.obj, mv.dat)
mkde.obj <- dens.res$mkde.obj
saveRDS(mkde.obj, file = "mkde.obj.rds")
