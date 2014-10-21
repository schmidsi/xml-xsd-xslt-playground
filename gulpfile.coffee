coffee   = require 'gulp-coffee'
fs       = require 'fs'
gulp     = require 'gulp'
jade     = require 'gulp-jade'
rename   = require 'gulp-rename'
libxml   = require 'libxmljs'
xslt     = require 'node_xslt'


gulp.task 'jade', ->
    return gulp.src './src/*.jade'
        .pipe jade({pretty: true})
        .pipe rename (path) ->
            path.extname = ''
        .pipe gulp.dest './build/'

gulp.task 'xsd', ['jade'], ->
    fs.readFile './build/workspace.xml', (err, data) ->
        xml = libxml.parseXml data.toString()

        fs.readFile './build/workspace.xsd', (err, data) ->
            xsd = libxml.parseXml data.toString()

            xml.validate(xsd)

            if (xml.validationErrors.length > 0)
                console.log(xml.validationErrors)
            else
                console.log('./build/workspace.xml', 'successfully validated')

gulp.task 'xsl', ['jade'], ->
    xsl  = xslt.readXsltFile('./build/transform2html.xsl')
    xml  = xslt.readXmlFile('./build/workspace.xml')
    html = xslt.transform(xsl, xml, [])

    fs.writeFile './index.html', html, (err) ->
        if err
            console.log err
        else
            console.log 'created ./index.html'

gulp.task 'coffee', ->
    return gulp.src('./src/script/*.coffee')
        .pipe(coffee(bare=true))
        .pipe(gulp.dest('./build/js/'))


gulp.task 'default', ['jade', 'xsd', 'xsl', 'coffee'], ->
    gulp.watch './src/*.jade', ['jade', 'xsd', 'xsl']
    gulp.watch './src/script/*.coffee', ['coffee']