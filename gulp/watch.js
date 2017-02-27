'use strict';

var path = require('path');
var gulp = require('gulp');
var conf = require('./conf');

var browserSync = require('browser-sync');
var gulpsync = require('gulp-sync')(gulp);

function isOnlyChange(event)
{
    return event.type === 'changed';
}

gulp.task('jade-dev', function(){
    return conf.jade()
      .pipe(gulp.dest(conf.paths.tmp + '/serve/app/'));

});

gulp.task('watch', gulpsync.sync(['inject', 'jade-dev']), function ()
{
    gulp.watch([path.join(conf.paths.src, '/*.html'), 'bower.json'], ['inject-reload']);

    gulp.watch([
        path.join(conf.paths.src, '/app/**/*.css'),
        path.join(conf.paths.src, '/app/**/*.{scss,sass}')
    ], function (event)
    {
        if ( isOnlyChange(event) )
        {
            gulp.start('styles-reload');
        }
        else
        {
            gulp.start('inject-reload');
        }
    });

    gulp.watch(path.join(conf.paths.src, '/app/**/*.{js,ls,json.ls}'), function (event)
    {
        if ( isOnlyChange(event) )
        {
            gulp.start('scripts-reload');
        }
        else
        {
            gulp.start('inject-reload');
        }
    });

    gulp.watch([
        path.join(conf.paths.src, '/app/**/*.json'),
        path.join(conf.paths.src, '/app/**/*.html')
    ], function (event)
    {
        browserSync.reload(event.path);
    });

    gulp.watch([
        path.join(conf.paths.src, '/app/**/*.jade'),
    ], function (event)
    {
        gulp.start('jade-dev');
        browserSync.reload(event.path);
    });
});
