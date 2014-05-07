var browserify   = require('browserify');
var gulp         = require('gulp');
var handleErrors = require('../util/handleErrors');
var livereload   = require('gulp-livereload');
var source       = require('vinyl-source-stream');
// var coffeelint   = require('gulp-coffeelint')
var plumber   = require('gulp-plumber')

gulp.task('browserify_dev', function(){

  var enviroments = ["editor","store"]
  enviroments.forEach(function (element, index, array) {
    console.log(element);
    return browserify({
        entries: ['./src/app/'+element+'.coffee'],
        extensions: ['.coffee'],
        transform: ["coffeeify","brfs","envify","browserify-shim"]
    })
//        .require('backbone/node_modules/underscore', { expose: 'underscore' })
    .bundle({debug: true})
    .on('error', handleErrors)
    .pipe(source(''+element+'.js'))
    .pipe(gulp.dest('./assets/js/'))
    .pipe(livereload());
  });
});