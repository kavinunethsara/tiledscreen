---
layout: article
title: Release 1.0
---

<img class="background" src="/assets/images/article-front.png" />

# Tiled Screen Version 1.0

This is the first stable release of Tiled Screen. Following this release, all Tiled Screen versions with 1.x versioning can be expected to be backward compatible with previous versions.

## Features

<div class="tile rounded blue">
    <div class="grid x2 adaptive stretch-width">
        <div class="flex column spaced">
            <h4> Redesigned tile selector </h4>
            <p> The tile selector now looks more consistent with the rest of the system. It is now also possible to install tiles directly using the <b>Install From File</b> button in the selector.</p>
        </div>
        <img src="/assets/images/v1-tile-menu.png" />
    </div>
</div>

<div class="tile rounded">
    <div class="grid x2 adaptive stretch-width">
        <img src="/assets/images/v1-backed-tiles.png" />
        <div class="flex column spaced">
            <h4> Background images for Icon tiles </h4>
            <p> It is now possible to add background images to icon tiles. If you want, you can also hide the icon from a tile.</p>
        </div>
    </div>
</div>

## Official Installable Tiles

<div class="tile rounded brown">
    <div class="grid x2 adaptive stretch-width">
        <div class="flex column spaced">
            <h4> Calendar Tile </h4>
            <p> Calendar is a new downloadable tile in the official collection. This provides the same calendar interface as the Calendar Plasma Widget with few customization options.</p>
        </div>
        <img src="/assets/images/v1-calendar.png" />
    </div>
</div>

<div class="tile rounded">
    <div class="grid x2 adaptive stretch-width">
        <img src="/assets/images/v1-outlined-binaryclock.png" />
        <div class="flex column spaced">
            <h4> Binary Clock: Border </h4>
            <p> It is now possible to add a border to Binary clock. The width of the border can be configured while the colour is taken from the active LED colour. </p>
        </div>
    </div>
</div>

## API Changes

1. Previous API version 0.9 is now deprecated. Wile the current version is still compatible with the API, support will be removed in future versions.
1. Introduction of API 1.0. This API provides a better, more intuitive interface for creating custom tiles. For more information, refer to the [documentation](/docs).

## Bug fixes

1. Selecting action types for Icon tiles now works as expected.
1. Removed broken D-Bus option from Icon tile's Action Types.
1. Right clicking on tiles situated under the scroll area now opens the tile's context menu instead of the general context menu.
