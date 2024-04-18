# The following code block dumps the parameters and data used for 2D mkde calculation
# Would insert in function calculateRaster2D() in compute.R, before the lines
#
# mv.dat <- initializeMovementData(t, x, y, sig2obs = sig2obs, t.max = t.max)
# mkde.obj <- initializeMKDE2D(xmin, cell.sz, nx, ymin, cell.sz, ny)
# dens.res <- initializeDensity(mkde.obj, mv.dat)
# mkde.obj <- dens.res$mkde.obj
#
# Will need to add code to the shniy app to export the data

data2d <- list(
  x = x,
  y = y,
  t = t,
  sig2obs = sig2obs,
  t.max = t.max,
  cell.sz = cell.sz,
  xmin = xmin,
  ymin = ymin,
  nx = nx,
  ny = ny
)
saveRDS(data2d, file = "data2d.rds")
