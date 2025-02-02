# SPDX-FileCopyrightText: 2025 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
# SPDX-License-Identifier: LGPL-2.1-or-later

import zipfile
import sys
import os
import json

if (len(sys.argv) != 2):
    print("ZipFile location required.")
    exit()

data = {}

def get_tile_path(path):
    return os.getenv("HOME", ".")+"/.local/share/tiledscreen/tiles/"+path

def mkdir(path):
    try:
        os.mkdir(path)
    except FileExistsError:
        return

with zipfile.ZipFile(sys.argv[1]) as package:
    data = {}
    try:
        with package.open("metadata.json") as metadata:
            data = json.loads(metadata.read())
            if not ('name' in data and 'plugin' in data):
                print("Not a valid tile archive.")
                exit()
    except:
        print("Not a valid tile archive.")
        exit()
    tileroot = get_tile_path(data['plugin'])
    mkdir(tileroot)
    package.extractall(tileroot)


