gulp    = require 'gulp'
gutil   = require 'gulp-util'
coffee  = require 'gulp-coffee'
compass = require 'gulp-compass'
concat  = require 'gulp-concat'
rename  = require 'gulp-rename'
uglify  = require 'gulp-uglify'

gulp.task 'default', ['scripts', 'compass', 'watch'], ->
  console.log 'Gulpin...'

gulp.task 'watch', ->
  gulp.watch('./src/coffeescripts/*.coffee', ['coffee'])
  gulp.watch('./src/javascripts/*.js', ['scripts'])
  gulp.watch('./src/scss/*.scss', ['compass'])

# Process all JS-related stuff
gulp.task 'scripts', ['coffee'], ->
  gulp.src('./src/javascripts/*.js')
    .pipe(concat('bundle.js'))
    .pipe(gulp.dest('./dist/javascripts/'))
    .pipe(rename('bundle.min.js'))
    .pipe(uglify())
    .pipe(gulp.dest('./dist/javascripts/'))

# Compile le Coffeescript
gulp.task 'coffee', ->
  gulp.src('./src/coffeescripts/*.coffee')
    .pipe(coffee(bare: true).on('error', gutil.log))
    .pipe(gulp.dest('./src/javascripts/'))

gulp.task 'compass', ->
  gulp.src('./src/scss/*.scss')
    .pipe(compass(config_file: './config.rb', css: './dist/stylesheets/', sass: './src/scss/'))