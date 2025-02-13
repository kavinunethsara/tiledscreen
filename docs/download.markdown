---
layout: default
title: Download
---
# Version 1.0
Download options

<div class="grid x2 adaptive center-content">
    <a class="tile rounded bordered" href="#plasma-get-new">
        <div class="flex column center-content">
            <div class="tile rounded cutout">
                <img src="{{site.baseurl}}/assets/images/edit-download.svg" width=100 height=100 />
            </div>
            <h4> Plasma Get New </h4>
            <p> Automatic installation </p>
            <p class="attention"> Recommended </p>
        </div>
    </a>
    <a class="tile rounded bordered" href="https://store.kde.org/p/2238981">
        <div class="flex column center-content">
            <div class="tile rounded cutout">
                <img src="{{site.baseurl}}/assets/images/globe.svg" width=100 height=100 />
            </div>
            <h4> KDE (Pling) Store </h4>
            <p> Manual install </p>
        </div>
    </a>
</div>

## Plasma Get New

<div class="flex row center-content spaced">
    <div class="tile gray rounded passive">
        <p> Use KDE Plasma's built in "Get New Widgets" dialog to install and update Tiled Screen </p>
        <ol>
            <li> <b>Right Click</b> on an empty space on the Desktop </li>
            <li> <i>Enter Edit Mode</i> -> <i>Add or Manage Widgets</i> -> <i>Get New</i> -> <i>Download new...</i> </li>
            <li> Search for <b> TiledScreen </b> </li>
            <li> Click <i>Download</i> and select the latest version </li>
        </ol>
        <p> You can update widgets later using the same steps. </p>
    </div>
</div>

## From Source

<div class="flex row center-content spaced">
    <div class="tile gray rounded passive">
        <p> If you want to test tiled screen or wants to have the latest development build, you would need to install it from the source. </p>
        <div class="highlight">
            <pre class="codehilite">
                <code>
                    <span class="nv">$ </span><span class="nb">cd </span>path/to/save/source
                    <span class="nv">$ </span>git clone https://github.com/kavinunethsara/tiledscreen
                    <span class="nv">$ </span><span class="nb">cd </span>tiledscreen
                    <span class="nv">$ </span><span class="nb">mkdir </span>build
                    <span class="nv">$ </span><span class="nb">cd </span>build
                    <span class="nv">$ </span>cmake .. <span class="nt">-DCMAKE_INSTALL_PREFIX</span><span class="o">=</span><span class="nv">$HOME</span>/.local/
                    <span class="nv">$ </span>make <span class="nb">install</span>
                </code>
            </pre>
        </div>
    </div>
</div>
