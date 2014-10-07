fs 		 = require 'fs'
gulp     = require 'gulp'
jade     = require 'gulp-jade'
rename   = require 'gulp-rename'
libxml   = require 'libxmljs'


gulp.task 'jade', ->
	return gulp.src './src/*.jade'
		.pipe jade({pretty: true})
		.pipe rename (path) ->
			path.extname = ''
		.pipe gulp.dest './build/'

gulp.task 'xsd', ['jade'], ->
	fs.readFile './build/persons.xml', (err, data) ->
		xml = libxml.parseXml data.toString()

		fs.readFile './build/persons.xsd', (err, data) ->
			xsd = libxml.parseXml data.toString()

			xml.validate(xsd)

			if (xml.validationErrors.length > 0)
				console.log(xml.validationErrors)
			else
				console.log('./build/persons.xml', 'successfully validated')

gulp.task 'default', ->
	gulp.watch './src/*.jade', ['jade', 'xsd']