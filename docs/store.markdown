---
layout: default
title: Store
cover: "{{site.baseurl}}/assets/images/article-front.png"
---
<img class="background" src="{{site.baseurl}}/assets/images/article-front.png" />

# Store

<blockquote class="danger">
    Products listed here has not been verified for security, functionality or stability. Use at your own discretion.
</blockquote>

<blockquote class="error" id="js">
    JavaScript support is required for this website to function. Please enable JavaScript in your browser.
</blockquote>
<script>
    document.querySelector('#js').remove()
</script>

<input type="text" name="search" placeholder="Search" onInput="search(this)" />

<div class="grid x2 equal adaptive center-content" id="tiles">
</div>
<div class="flex stretch-width row center-content">
    <button id="loadmore" onclick='extend()'> Load More ... </button>
</div>

<script src="https://cdn.jsdelivr.net/npm/fuse.js@7.1.0"></script>
<script>
    const tiles = [
        {% for tile in site.tiles %}
        {
            title: "{{tile.title}}",
            excerpt: "{{tile.excerpt}}",
            url: "{{site.baseurl}}/{{tile.url}}",
            domain: "{{tile.domain}}",
            thumbnail: "{{tile.thumbnail}}",
            author: "{{tile.author}}",
            license: "{{tile.license}}",
            version: "{{tile.version}}",
            tags: [
                {% for tag in tile.tags %}
                '{{tag}}',
                {% endfor %}
            ]
        },
        {% endfor %}
    ]
    
    let filtered = [ ]
    let filter = ""
    
    const options = {
    includeScore: true,
    keys: [
        {
        name: 'title',
        weight: 0.9
        },
        {
        name: 'tags',
        weight: 0.75
        },
        {
        name: 'author',
        weight: 0.5
        },
        {
        name: 'excerpt',
        weight: 0.3
        }
    ]
    }
    
    const Tile = (data) => (
        `<a class="tile rounded gray fill-available" href="${data.url}">
            <img src="{{site.baseurl}}/assets/images/tiles/${data.domain}/${data.thumbnail}" />
            <div class="flex column spaced">
                <div class="flex row center-content">
                    <h4 class="flex stretch-width"> ${data.title} </h4>
                    <pre> Version ${data.version} </pre>
                </div>
                <p> ${data.excerpt} </p>
                <p><i>${ data.author }, ${ data.license }</i></p>
                <div class="flex row">
                ${ data.tags.map(tag => `<span class="tag" >${ tag }</span>` ).reduce((acc, tag) => acc + tag) }
                </div>
            </div>
        </a>`
    )
    
    const refreshTiles = () => {
        tileHolder.innerHTML = ""
        filtered.forEach(item => {
            tileHolder.innerHTML += Tile(item)
        })
        
        document.querySelector("#loadmore").disabled = (filtered.length == tiles.length) || filter != ""
    }
    
    const tileHolder = document.querySelector("#tiles")

    // Create a new instance of Fuse
    const fuse = new Fuse(tiles, options)
    
    const search = ({value}) => {
        filter = value
        if (value != "") {
            const result = fuse.search(value)
            if (!result) return
            filtered = result.map(data => data.item)
        } else {
            filtered = [ ...tiles.slice(0,5) ]
        }
        refreshTiles()
    }
    
    const extend = () => {
        if (filter != "") return
        if (filtered.length == tiles.length) return
        const len = ( filtered.length + 5 <= tiles.length ) ? filter.length + 5 : tiles.length
        filtered = [ ...tiles.slice(0, len) ]
        refreshTiles()
    }
    
    extend()
    
</script>
