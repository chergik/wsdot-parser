###
# Install coffee-script first.
# $ sudo npm install coffee-script -g
#
# Then download the json file from wsdot.
#
# Run the program with input file as the resource:
# $ coffee app.coffee --in=wsdot-file.json --out=../somedir/newfile.json
# or with a remote url:
# $ coffee app.coffee --in=https://data.seattle.gov/api/views/2az7-96yc/rows.json?accessType=DOWNLOAD \
#                     --out=../intersections.json
###

fs      = require 'fs'
url     = require 'url'
request = require 'request'

module.exports = (resource, out, cb=null) ->

  debug = (message) ->
    console.log message unless cb

  unless resource
    msg = "No input file given"
    if cb then cb(msg, null) else throw new Error(msg)
  unless out
    msg = "No output file given"
    if cb then cb(msg, null) else throw new Error(msg)

  urlObj = url.parse resource

  if urlObj.protocol?.match /http(?:s)?/
    debug "Sending request to the remote resource. Retrieving data."
    chunksCount = 0

    request.get(url.format(urlObj), (err, resp, body) ->
      if err
        msg = "Remote resource request failed with an error: #{JSON.stringify err, null, 4}"
        if cb then cb(msg, null) else throw new Error(msg)
      else
        parseData body, cb
    ).on('response', (response) ->
      debug "Progress: "
    ).on('data', (chunk) ->
      process.stdout.write '.' if chunksCount++ % 10 is 0
    )

  else if urlObj.path?
    fs.readFile urlObj.path, (err, dataset) ->
      if err
        msg = "Error reading input file #{urlObj.path}: #{JSON.stringify err}"
        if cb then cb(msg, null) else throw new Error(msg)
      else
        parseData(dataset, cb)

  else
    msg = "Provided --in value is neither path nor url."
    if cb then cb(msg, null) else throw new Error(msg)

  parseData = (dataset, cb=null) ->
    debug "\nResource #{url.format urlObj} succesfully consumed and is about to be processed."

    debug "Trying to parse resource content as JSON."
    dataset = JSON.parse dataset
    debug "Data successfully parsed as JSON."

    debug "Fetching headers."
    headers = (column.name for column in dataset.meta.view.columns)
    debug "Headers are: #{headers.join ', '}"

    debug "Mapping headers and columns data."
    results = []
    results = for row, i in dataset.data
      newRow = {}
      newRow[headers[j]] = value for value, j in row
      results.push newRow

    if cb
      cb(null, results)
    else
      debug "Stringifying mapped data to JSON."
      resultsJson = JSON.stringify results, null, 4

      debug "Saving pretty data to the new out file \"#{out}\"."
      fs.writeFile out, results, (err) ->
        if err
          throw new Error("Error during saving data to the file \"#{out}\": #{err}")
        else
          debug "File \"#{out}\" successfully saved."

