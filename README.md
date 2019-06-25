# A toy (minimal) R package example

The package was created by RStudio IDE (File > New Project > New Directory > R Package).


## Test a local package via Docker

You can quickly test the installation of the package using [Docker](https://www.docker.com/).

```
$ git clone https://github.com/arraytools/rtoy.git
$ cd rtoys
$ docker run -it --rm -v $(pwd):/rtoy r-base
```

```
> system("ls")
bin   dev  home  lib64	mnt  proc  rtoy  sbin  sys  usr
boot  etc  lib	 media	opt  root  run	 srv   tmp  var

> system("ls rtoy")
DESCRIPTION  man  NAMESPACE  R	rtoy.Rproj
> system("R CMD INSTALL /rtoy")
* installing to library ‘/usr/local/lib/R/site-library’
* installing *source* package ‘rtoy’ ...
** using staged installation
** R
** byte-compile and prepare package for lazy loading
** help
*** installing help indices
** building package indices
** testing if installed package can be loaded from temporary location
** testing if installed package can be loaded from final location
** testing if installed package keeps a record of temporary installation path
* DONE (rtoy)
> library(rtoy)
> hello()
[1] "Hello, world!"
> q()
```

## Add a dependency in our local package

To add a dependency, try to add a new line `Imports: Rcpp` ([needs compilation](https://github.com/cran/Rcpp)) or `Imports: packrat` ([no compilation](https://github.com/cran/packrat)) after Description in `DESCRIPTION` file. Afterwards, test installing the package by

```
> install.packages("remotes")
> remotes::install_local("rtoy")
```

## Packrat

Still under a Docker environment.

```
> install.packages("packrat")
> packrat::init("/home/docker") # root directory won't work?
# For local packages, we can still use remotes::install_local()
# But when we run packrat::snapshot(), it will show an error
# Error: unable to retrieve package records for ...

# packrat issues errors when install local packages that have
# a dependency on other packages on CRAN. See
# https://stackoverflow.com/q/28098785
# Possible solutions are
# 1. manually install dependency packages
# 2. use remotes::install_local() to install dependency
#    package and then use packrat::install_local() again 
#    to install the local package.
> install.packages("remotes")
> remotes::install_local("/rtoy")  # notice the absol directory
> packrat::set_opts(local.repos = "/")
> packrat::install_local("rtoy")
> packrat::snapshot()  # Rcpp, remotes and rtoy are added
> packrat::bundle(include.bundles = FALSE)
The packrat project has been bundled at:
- "/home/docker/packrat/bundles/docker-2019-06-25.tar.gz"

> untar("/home/docker/packrat/bundles/docker-2019-06-25.tar.gz", list = TRUE)
 [1] "docker/.Rprofile"                               
 [2] "docker/packrat/"                                
 [3] "docker/packrat/init.R"                          
 [4] "docker/packrat/packrat.lock"                    
 [5] "docker/packrat/packrat.opts"                    
 [6] "docker/packrat/src/"                            
 [7] "docker/packrat/src/packrat/"                    
 [8] "docker/packrat/src/packrat/packrat_0.5.0.tar.gz"
 [9] "docker/packrat/src/Rcpp/"                       
[10] "docker/packrat/src/Rcpp/Rcpp_1.0.1.tar.gz"      
[11] "docker/packrat/src/remotes/"                    
[12] "docker/packrat/src/remotes/remotes_2.1.0.tar.gz"
[13] "docker/packrat/src/rtoy/"                       
[14] "docker/packrat/src/rtoy/rtoy_0.1.0.tar.gz"
> getwd()
[1] "/home/docker"
> dir()
[1] "packrat"

> args(packrat::bundle)
function (project = NULL, file = NULL, include.src = TRUE, include.lib = FALSE, 
    include.bundles = TRUE, include.vcs.history = FALSE, overwrite = FALSE, 
    omit.cran.src = FALSE, ...) 
NULL
```

PS. 

1. no need to run `$ sudo rm .Rprofile; sudo rm -rf packrat` unless we mount some local directory to `/home/docker`.
2. We can use `packrat::unbundle()` or the `tar` command to extract the tarball on a new environment and use `packrat::restore()` to restore all R packages.
3. `packrat::bundle()` will zip most of things under the current directory. 

    3.1 If we just need to reproduce the R enviroment, we use a new directory; such as `packrat.init("project")`. This will create a new directory "project" and `packrat` subdirectory will be under it.

    3.2 If we want to zip everything under the current working directory, we can use `packrat.init()`. The `packrat` subdirectory will be created under the current directory.

