# Load all required libraries.
gulp   = require 'gulp'
jade   = require 'gulp-jade'
rename = require 'gulp-rename'


gulp.task 'jade', ->
	gulp.src './src/*.jade'
		.pipe jade({pretty: true})
		.pipe rename (path) ->
			path.extname = ''
		.pipe gulp.dest './build/'

gulp.task 'default', ->
	gulp.watch './src/*.jade', ['jade']