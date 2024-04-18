This document describes the steps needed to create the conda environment on Expanse needed to execute mkde.
The updates described below to the mkde package will be pushed to CRAN once transtion from sp and raster
to terra has been completed.

### Create conda environment and install packages

For reasons that aren't entirely clear, the boost install using the default channel does not work,
using the anaconda channel fixes.

```
conda update -n base -c defaults conda  
conda create -n r_seg r-base. 
conda activate r_seg  
conda install -c anaconda boost  
conda install udunits2  
conda install gdal
```

launch R, then do following from prompt

```
install.packages('Rcpp')  
install.packages('sf')  
install.packages("codetools")
``` 

### terra install

Install chokes when building RcppModule.o with
x86_64-conda-linux-gnu-c++, use the following to manually build this
object with g++, create new archive and install from command line.

```wget https://cran.r-project.org/src/contrib/terra_1.7-71.tar.gz
gunzip -xzf terra_1.7-71.tar.gz
cd terra/src
```
```
g++ -std=gnu++17 -I"/home/seg/miniconda3/envs/r_seg/lib/R/include" -DNDEBUG -DHAVE_PROJ_H -I/home/seg/miniconda3/envs/r_seg/include -I/home/seg/miniconda3/envs/r_seg/include -I'/home/seg/miniconda3/envs/r_seg/lib/R/library/Rcpp/include' -DNDEBUG -D_FORTIFY_SOURCE=2 -O2 -isystem /home/seg/miniconda3/envs/r_seg/include -I/home/seg/miniconda3/envs/r_seg/include -Wl,-rpath-link,/home/seg/miniconda3/envs/r_seg/lib    -fpic  -fvisibility-inlines-hidden  -fmessage-length=0 -march=nocona -mtune=haswell -ftree-vectorize -fPIC -fstack-protector-strong -fno-plt -O2 -ffunction-sections -pipe -isystem /home/seg/miniconda3/envs/r_seg/include -fdebug-prefix-map=/workspace/croot/r-base_1695428141831/work=/usr/local/src/conda/r-base-4.3.1 -fdebug-prefix-map=/home/seg/miniconda3/envs/r_seg=/usr/local/src/conda-prefix  -c RcppModule.cpp -o RcppModule.o
```

```
cd
tar -cf terra_new_1.7-71.tar.gz terra
R CMD INSTALL terra_new_1.7-71.tar.gz
```

### mkde install

In DESCRIPTION make following edit

```Imports: Rcpp (>= 0.9.6), sp, raster --> Imports: Rcpp (>= 0.9.6), sf, terra```

Then make new mkde package with automatically built NAMESPACE, but need to add 

```useDynLib(mkde, .registration = TRUE)```

```
R CMD build mkde
mv mkde_0.2.tar.gz mkde_new_0.2.tar.gz
R CMD INSTALL mkde_new_0.2.tar.gz
```

### Additional notes

Get the following warnings during terra install from command line after building RcppModule.o

```
** byte-compile and prepare package for lazy loading
in method for ‘sds’ with signature ‘x="stars"’: no definition for class “stars”
in method for ‘sds’ with signature ‘x="stars_proxy"’: no definition for class “stars_proxy”
in method for ‘svc’ with signature ‘x="sf"’: no definition for class “sf”
in method for ‘coerce’ with signature ‘"stars","SpatRasterDataset"’: no definition for class “stars”
in method for ‘coerce’ with signature ‘"ggmap","SpatRaster"’: no definition for class “ggmap”
in method for ‘coerce’ with signature ‘"sf","SpatRaster"’: no definition for class “sf”
in method for ‘coerce’ with signature ‘"sf","SpatVector"’: no definition for class “sf”
in method for ‘coerce’ with signature ‘"sfc","SpatVector"’: no definition for class “sfc”
in method for ‘coerce’ with signature ‘"sfg","SpatVector"’: no definition for class “sfg”
in method for ‘coerce’ with signature ‘"XY","SpatVector"’: no definition for class “XY”
in method for ‘coerce’ with signature ‘"im","SpatRaster"’: no definition for class “im”
in method for ‘coerce’ with signature ‘"SpatVector","Spatial"’: no definition for class “Spatial”
in method for ‘coerce’ with signature ‘"Spatial","SpatVector"’: no definition for class “Spatial”
in method for ‘coerce’ with signature ‘"SpatialGrid","SpatRaster"’: no definition for class “SpatialGrid”
in method for ‘coerce’ with signature ‘"SpatialPixels","SpatRaster"’: no definition for class “SpatialPixels”
in method for ‘crs’ with signature ‘"sf"’: no definition for class “sf”
Creating a generic function for ‘ncol’ from package ‘base’ in package ‘terra’
in method for ‘distance’ with signature ‘x="SpatRaster",y="sf"’: no definition for class “sf”
in method for ‘ext’ with signature ‘x="sf"’: no definition for class “sf”
in method for ‘ext’ with signature ‘x="bbox"’: no definition for class “bbox”
in method for ‘ext’ with signature ‘x="Extent"’: no definition for class “Extent”
in method for ‘ext’ with signature ‘x="Raster"’: no definition for class “Raster”
in method for ‘ext’ with signature ‘x="Spatial"’: no definition for class “Spatial”
in method for ‘extract’ with signature ‘x="SpatRaster",y="sf"’: no definition for class “sf”
in method for ‘mask’ with signature ‘x="SpatRaster",mask="sf"’: no definition for class “sf”
in method for ‘points’ with signature ‘x="sf"’: no definition for class “sf”
in method for ‘lines’ with signature ‘x="sf"’: no definition for class “sf”
in method for ‘polys’ with signature ‘x="sf"’: no definition for class “sf”
in method for ‘lines’ with signature ‘x="leaflet"’: no definition for class “leaflet”
in method for ‘points’ with signature ‘x="leaflet"’: no definition for class “leaflet”
in method for ‘rast’ with signature ‘x="stars"’: no definition for class “stars”
in method for ‘rast’ with signature ‘x="stars_proxy"’: no definition for class “stars_proxy”
in method for ‘rasterize’ with signature ‘x="sf",y="SpatRaster"’: no definition for class “sf”
in method for ‘show’ with signature ‘"Rcpp_SpatDataFrame"’: no definition for class “Rcpp_SpatDataFrame”
in method for ‘show’ with signature ‘"Rcpp_SpatCategories"’: no definition for class “Rcpp_SpatCategories”
in method for ‘geomtype’ with signature ‘x="Spatial"’: no definition for class “Spatial”
Creating a generic function for ‘identical’ from package ‘base’ in package ‘terra’
in method for ‘vect’ with signature ‘x="Spatial"’: no definition for class “Spatial”
in method for ‘vect’ with signature ‘x="sf"’: no definition for class “sf”
in method for ‘vect’ with signature ‘x="sfc"’: no definition for class “sfc”
in method for ‘vect’ with signature ‘x="XY"’: no definition for class “XY”
Creating a generic function for ‘unserialize’ from package ‘base’ in package ‘terra’
Creating a generic function for ‘readRDS’ from package ‘base’ in package ‘terra’
```

Got following error when doing install.packages("terra"). Avoided by taking steps described earlier

```
x86_64-conda-linux-gnu-c++ -std=gnu++17 -I"/home/seg/miniconda3/envs/r_seg/lib/R/include" -DNDEBUG -DHAVE_PROJ_H -I/home/seg/miniconda3/envs/r_seg/include -I/home/seg/miniconda3/envs/r_seg/include -I'/home/seg/miniconda3/envs/r_seg/lib/R/library/Rcpp/include' -DNDEBUG -D_FORTIFY_SOURCE=2 -O2 -isystem /home/seg/miniconda3/envs/r_seg/include -I/home/seg/miniconda3/envs/r_seg/include -Wl,-rpath-link,/home/seg/miniconda3/envs/r_seg/lib    -fpic  -fvisibility-inlines-hidden  -fmessage-length=0 -march=nocona -mtune=haswell -ftree-vectorize -fPIC -fstack-protector-strong -fno-plt -O2 -ffunction-sections -pipe -isystem /home/seg/miniconda3/envs/r_seg/include -fdebug-prefix-map=/workspace/croot/r-base_1695428141831/work=/usr/local/src/conda/r-base-4.3.1 -fdebug-prefix-map=/home/seg/miniconda3/envs/r_seg=/usr/local/src/conda-prefix  -c RcppModule.cpp -o RcppModule.o
{standard input}: Assembler messages:
{standard input}: Error: open CFI at the end of file; missing .cfi_endproc directive
x86_64-conda-linux-gnu-c++: fatal error: Killed signal terminated program cc1plus
compilation terminated.
make: *** [/home/seg/miniconda3/envs/r_seg/lib/R/etc/Makeconf:200: RcppModule.o] Error 1
```
