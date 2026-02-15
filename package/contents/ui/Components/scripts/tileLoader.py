# SPDX-FileCopyrightText: 2024 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
# SPDX-License-Identifier: LGPL-2.1-or-later


import os as os
import sys as sys
import json as json

def error(error):
    print(json.dumps({'error': error}, indent=4))

def mkdir(path):
    try:
        os.mkdir(os.getenv("HOME", ".")+path)
    except FileExistsError:
        return

def extractpath(loc):
    return loc.path

def installedtiles():
    path = os.getenv("HOME", ".")+"/.local/share/tiledscreen/tiles"
    locs = []
    try:
        locs = map(extractpath,os.scandir(path))
    except FileNotFoundError:
        mkdir("/.local")
        mkdir("/.local/share")
        mkdir("/.local/share/tiledscreen")
        mkdir("/.local/share/tiledscreen/tiles")
    return locs


def gettiles():
    folders = []
    folders += map(extractpath,os.scandir(sys.argv[1]))
    folders += installedtiles()
    tiles = []
    for folder in folders:
        direct = {}
        try:
            direct = os.scandir(folder)
        except:
            continue
        for entry in direct:
            if (entry.name == "metadata.json" or entry.name == "tile.json"):
                metafile = open(entry.path, 'r')
                try:
                    metadata = json.loads(metafile.read())
                except:
                    continue
                metadata['path'] = folder
                tiles.append(metadata)
    print(json.dumps(tiles))

gettiles()
