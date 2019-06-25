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
