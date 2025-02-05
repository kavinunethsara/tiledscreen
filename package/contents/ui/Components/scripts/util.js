// This keeps track of the tile config and automatically updates the model
class TileData {
    constructor(root, defaults){
        this.root = root
        this.model = root.model
        this.metadata = JSON.parse(this.model.metadata)

        const dataObj =  Object.entries(defaults)

        dataObj.forEach(([key, _value]) => {

            this.__defineGetter__(key,() => this.metadata[key] ? this.metadata[key] : defaults[key] )

            this.__defineSetter__(key, (val) => {
                this.metadata[key] = val
                this.model.metadata = JSON.stringify(this.metadata)
                this.setChange()
            })
        })
    }

    get height() {
        return this.model.tileHeight
    }

    set height(value) {
        this.model.tileHeight = value
        this.setChange()
    }

    get width() {
        return this.model.tileWidth
    }

    set width(value) {
        this.model.tileWidth = value
        this.setChange()
    }

    setChange() {
        this.root.configChanged()
        this.root.tileData = this.metadata
    }
}
