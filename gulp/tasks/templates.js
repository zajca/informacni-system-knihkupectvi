var gulp         = require('gulp');
var jade         = require('gulp-jade');

gulp.task('templates', function() {
    gulp.src(["./src/**/*.html"])
    .pipe(gulp.dest("./assets/partials"));

    gulp.src(["./src/**/*.jade"])
    .pipe(jade({
        pretty:true,
        debug:false
    }))
    .pipe(gulp.dest("./assets/partials"));
});