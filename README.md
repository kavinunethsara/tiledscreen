# TiledScreen
## A Tile based launcher screen for KDE Plasma

_Plasma 6.x only_, requires **Python 3**, **Qt6** and **KDE Frameworks 6**

## Custom Tiles

Custom tiles should be located in `$HOME/.local/share/tiledscreen/tiles/`

Currently installing tiles needs to be done manually by copying its file into a sub-directory.

## Writing custom tiles

An example tile can be found on [Binary Clock TIle](https://github.com/kavinunethsara/BinaryclockTile).

Custom tiles usually has the following structure

```
tilename
├── metadata.json
├── TileConfig.qml
└── Tile.qml
```

- **metadata.json** : Holds the metadata and default configuration for the tile
- **Tile.qml**      : The tile's entry point. File name can be anything as long as its correctly set in `metadata.json`
- **TileConfig.qml**: Configuration screen for the tile. File name should be set in `metadata.json`

### metadata.json

Following JSON values are required

    1.name: User visible name.
    2.plugin: Unique name used internally.
    3.description: A short description of the tile
    4.icon: Icon to be used
    5.config: Configuration window (TileConfig.qml in the file structure above )
    6.main: QML file for the tile (Tile.qml in the file structure above)
    7.preferredHeight,preferredWidth: The default height and width ( in grid cells )
    8.defaults: A JSON object with default values for tile configuration. All configuration keys used within the tile should be included here. Only primitive types like String, Float, Boolean , Int etc. can be used.
    
An example `metadata.json`:

```json
{
    "name": "Binary Clock",
    "plugin": "com.your.domain.binaryclock",
    "description": "Display time as a binary pattern",
    "icon": "clock",
    "main": "Tile.qml",
    "config": "TileConfig.qml",
    "preferredWidth": 3,
    "preferredHeight": 2,
    "defaults": {
        "showBackground": true,
        "roundedCorners": true,
        "showSeconds": true,
        "showOffLeds": false,
        "useCustomColorForActive": false,
        "useCustomColorForInactive": false,
        "activeColor": "black",
        "inactiveColor": "white"
    }
}

```
> Do not define 'height' or 'width' as configuration fileds using the defaults. This will interfere with configuration of the tiles

> Following documentation is for TiledScreen V 1.x . Older API for v 0.9.x is now deprecated and may be removed from a later version. Using the older and newer APIs together can result in unwanted behavior

### Tile internals

The tile should have the following properties defined:

```qml
required property var container // Holds the Tile parent element
required property var metadata // Holds the Tile configuration
```

metadata property will hold the tile configuration as an JavaScript Object.
The container property is a reference to the underlying Tile component. It's properties and structure is explained in [Tile component](#tile-component)

Additionally, following function is triggered when the tile is clicked.

```qml
function activate (handler) {} // Event handler is passed down as the handler parameter
```

If this function is defined, it will be triggered when the tile is clicked, optionally passing the event along as the `handler ` parameter. Tiled Screen will automatically close after this function's return. If it's `undefined` the event will be passed through and Tiled Screen will not close.

To fit the tile properly, The tile's root element needs to be configured as below

```qml
anchors.fill: parent
anchors.margins: Kirigami.Units.smallSpacing // Recommended so that the tile would leave a gap around itself
```

Note that not setting `anchors.margins` will make the tile stretch to the edges of the tile cell.
This might be useful if the tiles of the same type needs to look connected to each other.

In the tile configuration component

```qml
required property var config // The configuration for the tile
```

This provides direct access to the tile configuration.

### Tile component

The `Tile` component has the following properties

```qml
property var tileData // Tile metadata as an JS Object
property var model // Current tile's underlying model
property var controller // Tile Grid component
```

The `model` property contains a `ListElement` with following properties

```javascript
{
    id: 1, // Unique id,
    plugin: "icon", // Tile type
    tileHeight: 2, // Tile's height in grid cells
    tileWidth: 2, // Tile width in grid cells
    row: 0, // Tile position, row
    column: 0, // Tile position, column
    metadata: "{ name: '' }" // Tile configuration as a JSON string
}
```

`tileData` property contains the configuration values for the tile stored as a JS Object.

### Tile configuration

Tile configuration is changed by setting the relevant values of `config` property.

For changing tile width/height from the configuration component:

```javascript
config.width = 2
config.height = 2
```

> Do not define height and width as configuration fields for the tile ( from 'defaults' ).
> This will interfere with the tile height and width configuration and may behave irratically

For changing a configuration value for the tile (setting configuration `useBinding` to `true`) :

```javascript
config.useBinding = true
```

If defined, `grouping` configuration key acts as a special option. When `grouping` is `true`, the all tiles directly below this tile will move together.

> Note that while setting the Tile's row and column from the tile itself or through the configration component is possible, this is not recommended and can break grouping behaviour

## Build instructions

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
