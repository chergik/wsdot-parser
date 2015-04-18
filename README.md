
### Install coffee-script first.
```$ sudo npm install coffee-script -g```

### Run the program with input file as the resource:
```$ coffee app.coffee --in=wsdot-file.json --out=../somedir/newfile.json```
### or with a remote url:
```
$ coffee app.coffee --in=https://data.seattle.gov/api/views/2az7-96yc/rows.json?accessType=DOWNLOAD \
                    --out=../intersections.json
```

