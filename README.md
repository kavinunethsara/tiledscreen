# TiledScreen
## A Tile based launcher screen for KDE Plasma

_Plasma 6.x only_, requires **Python 3**, **Qt6** and **KDE Frameworks 6**

### Writing custom tiles

TODO

### Build instructions

```bash
cd /place/you/cloned/to/
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=MYPREFIX .. 
make 
make install
```

(MYPREFIX is where you install your Plasma setup, replace it accordingly)

Restart plasma to load the applet :

in a terminal type:

`kquitapp plasmashell`

and then

`plasmashell`

or view it with 
`plasmoidviewer -a YourAppletName`
