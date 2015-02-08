##############################################
## Github Latest Commits Widget
## Author: Tyler Hughes <iampbt@gmail.com>
## -------------------------------------------
## Run gulp watch for development
## Run gulp --type production to build project
##############################################


gulp       = require 'gulp'
$          = do require 'gulp-load-plugins'
browserify = require 'browserify'
source     = require 'vinyl-source-stream'

## Test to determine dev/prod
isProd = $.util.env.production?

## Set env-specific build directory
buildDir = if isProd then './dist' else './tmp'

## Compile scripts
gulp.task 'scripts', ->
  browserify './src/javascripts/app.coffee', extensions: ['.coffee']
  .bundle()
  .pipe source 'bundle.js'
  .pipe $.if(isProd, $.streamify($.uglify()))
  .pipe gulp.dest "./#{buildDir}/javascripts"


## Compile stylesheets
gulp.task 'styles', ->
  gulp.src './src/stylesheets/screen.scss'
  .pipe $.sass includePaths: ['./bower_components']
  .pipe $.autoprefixer()
  .pipe gulp.dest "./#{buildDir}/stylesheets"


## Build & copy index.html
gulp.task 'index', ->
  target  = gulp.src './src/index.html'
  targetDest = if isProd then '.' else './tmp'
  sources = gulp.src ["#{buildDir}/javascripts/*.js", "#{buildDir}/stylesheets/*.css"], 
    read: false # We just need the paths, so this is faster
  target
    .pipe $.inject sources
    .pipe gulp.dest targetDest


## Watch & rebuild files / serve dev preview
gulp.task 'watch', ['default'], ->
  gulp.watch('./src/javascripts/*.coffee', ['scripts'])
  gulp.watch('./src/stylesheets/*.scss', ['styles'])
  gulp.watch './src/index.html', ['index']

  gulp.src '.'
  .pipe $.webserver
    livereload: true
    fallback: 'tmp/index.html'
    open: 'tmp/index.html/?username=twbs&repo=bootstrap'


gulp.task 'default', ['scripts', 'styles', 'index']