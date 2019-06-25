# A toy (minimal) R package example

The package was created by RStudio IDE (File > New Project > New Directory > R Package).


You can quickly test the installation of the package using [Docker](https://www.docker.com/).

```
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

## Extra

To add a dependency, try to add a new line `Imports: Rcpp` ([needs compilation](https://github.com/cran/Rcpp)) or `Imports: packrat` ([no compilation](https://github.com/cran/packrat) after Description in `DESCRIPTION` file. Afterwards, test installing the package by

```
> install.packages("remotes")
> remotes::install_local("rtoy")
```

## Packrat

```
> install.packages("packrat")
> packrat::init("/home/docker")
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
> remotes::install_local("rtoy")
> packrat::set_opts(local.repos = "/")
> packrat::install_local("rtoy")
> packrat::snapshot()
> packrat::bundle()
The packrat project has been bundled at:
- "/home/docker/packrat/bundles/docker-2019-06-25.tar.gz"
```

PS. 

1. no need to run `$ sudo rm .Rprofile; sudo rm -rf packrat` unless we mount some local directory to `/home/docker`.
2. We can use `packrat::unbundle()` or the `tar` command to extract the tarball on a new environment and use `packrat::restore()` to restore all R packages.


