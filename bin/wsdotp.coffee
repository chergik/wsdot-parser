argv = require('yargs').argv
path = require 'path'
fs   = require 'fs'

realpath = fs.realpathSync __filename
realdir = path.dirname realpath

module_root = path.join realdir, '..'

throw new Error("No input file given") unless argv.in
throw new Error("No output file given") unless argv.out

require(path.join module_root, 'app')(argv.in, argv.out, true)
