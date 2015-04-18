
### Install coffee-script first.
```$ sudo npm install coffee-script -g```

### Run the program with input file as the resource:
```$ coffee app.coffee --in=wsdot-file.json --out=../somedir/newfile.json```
### or with a remote url:
```
$ coffee app.coffee --in=https://data.seattle.gov/api/views/2az7-96yc/rows.json?accessType=DOWNLOAD \
                    --out=../intersections.json
```
### Example json data could be downloaded from [here](http://catalog.data.gov/dataset/intersections)

### The output of the parser will look like an array of objects with key-value pairs:
```
[
    {
        "sid": 719742,
        "id": "719742",
        "position": null,
        "created_at": null,
        "created_meta": null,
        "updated_at": 0,
        "updated_meta": null,
        "meta": null,
        "OBJECTID": "719742",
        "INTR_ID": "7511",
        "GIS_XCOORD": "1273924.06942999991588294506072998046875",
        "GIS_YCOORD": "245435.13156999999773688614368438720703125",
        "COMPKEY": "25797",
        "COMPTYPE": "13",
        "UNITID": "14338",
        "SUBAREA": "NE",
        "UNITDESC": "7TH AVE NE AND NE 47TH ST",
        "ARTERIALCLASSCD": "2",
        "SHAPE": [
            null,
            "47.663146393000034",
            "-122.3207304519999",
            null,
            false,
            {
                "point": [
                    -122.3207304519999,
                    47.663146393000034
                ]
            }
        ],
        "SIGNAL_MAINT_DIST": " ",
        "SIGNAL_TYPE": "NONE"
    },
    ...
    {...}, 
    {...}
]
```
