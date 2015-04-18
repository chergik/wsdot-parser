###
# Install coffee-script first.
# $ sudo npm install coffee-script -g
#
# Then download the json file from wsdot.
#
# Run the program:
# $ coffee app.coffee --in=wsdot-file.json --out=../somedir/newfile.json
###

fs = require 'fs'
argv = require('yargs').argv

throw new Error("No input file given") unless argv.in
throw new Error("No output file given") unless argv.out

fs.readFile argv.in, (err, dataset) ->
  if err
    throw new Error("Error reading input file #{argv.in}: #{JSON.stringify err}")
  else
    console.log "File #{argv.in} succesfully consumed and is about to be processed."
    console.log "Trying to parse file contents as JSON."
    dataset = JSON.parse dataset
    console.log "Data successfully parsed as JSON."
    console.log "Fetching headers."
    headers = (column.name for column in dataset.meta.view.columns)
    console.log "Headers are: #{headers.join ', '}"
    console.log "Mapping headers and columns data."
    results = []
    for raw, i in dataset.data
      newRaw = {}
      newRaw[headers[j]] = value for value, j in raw
      results.push newRaw
    console.log "Stringifying mapped data to JSON."
    results = JSON.stringify results, null, 4
    console.log "Saving pretty data to the new out file \"#{argv.out}\"."
    fs.writeFile argv.out, results, (err) ->
      if err
        throw new Error("Error during saving data to the file \"#{argv.out}\": #{err}")
      else
        console.log "File \"#{argv.out}\" successfully saved."
