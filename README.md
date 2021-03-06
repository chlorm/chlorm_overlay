```
       ________   ___       ___
      /  _____/  /  /      /  /
     /  /       /  /      /  /
    /  /       /  /____  /  / _______  _______  ____  ____
   /  /       /  ___  / /  / /  __  / /  ____/ /    \/    \
  /  /_____  /  /  / / /  / /  /_/ / /  /     /  /\    /\  \
 /________/ /__/  /_/ /__/ /______/ /__/     /__/  \__/  \__\ TM
```

Chlorm's Gentoo Overlay
=======================
I am working to add packages that I use to this overlay.  I will also be working on my own forks here as well.

All packages added to this repo will be hosted at 
    [http://mirrors.chlorm.net/src/${PN}/${P}.tar.xz](http://mirrors.chlorm.net/src/)
to ensure availability and consistency.


To add this overlay to a Gentoo system, run the following command:

Stable:
```
layman -o https://raw.githubusercontent.com/Chlorm/chlorm_overlay/master/chlorm_overlay.xml -f -a chlorm
```
Testing:
```
layman -o https://raw.githubusercontent.com/Chlorm/chlorm_overlay/testing/chlorm_overlay.xml -f -a chlorm_testing
```


Note that you must have both dev-vcs/git and app-portage/layman installed on your system for this to work.
