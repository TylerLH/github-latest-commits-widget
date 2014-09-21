gulp       = require 'gulp'
plugins    = do require 'gulp-load-plugins'
browserify = require 'browserify'
source     = require 'vinyl-source-stream'

isProd = ->
  plugins.util.env.type is 'production'

gulp.task 'scripts', ->
  browserify './src/javascripts/app.coffee'
  .bundle()
  .pipe source 'bundle.js'
  .pipe plugins.if isProd(), plugins.rename 'bundle.min.js'
  .pipe plugins.if isProd(), plugins.uglify()
  .pipe gulp.dest './dist/javascripts'

gulp.task 'styles', ->
  gulp.src './src/stylesheets/screen.scss'
  .pipe plugins.sass includePaths: ['bower_components']
  .pipe plugins.autoprefixer()
  .pipe gulp.dest './dist/stylesheets'

gulp.task 'watch', ->
  gulp.watch('./src/javascripts/*.coffee', ['scripts'])
  gulp.watch('./src/stylesheets/*.scss', ['styles'])

gulp.task 'default', ['scripts', 'styles']