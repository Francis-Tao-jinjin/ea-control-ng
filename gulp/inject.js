'use strict';

var path = require('path');
var gulp = require('gulp');
var conf = require('./conf');

var $ = require('gulp-load-plugins')({
    pattern: ['gulp-*', 'merge-stream']
});

var wiredep = require('wiredep').stream;
var _ = require('lodash');

var browserSync = require('browser-sync');
var gulpsync = require('gulp-sync')(gulp);

gulp.task('inject-reload', ['inject'], function ()
{
    browserSync.reload();
});

var jsonFilter = $.filter(['**/*', '!**/*.json'], {restore: true});


gulp.task('inject', gulpsync.sync(['clean:code', ['scripts', 'styles']]), function ()
{
    var injectStyles = gulp.src([
        path.join(conf.paths.tmp, '/serve/app/**/*.css'),
        path.join('!' + conf.paths.tmp, '/serve/app/vendor.css')
    ], {read: false});

    var _livescripts = conf.livescript();
    var _javascripts = gulp.src([
            path.join(conf.paths.src, '/app/**/*.module.js'),
            path.join(conf.paths.src, '/app/**/*.js'),
            path.join('!' + conf.paths.src, '/app/**/*.spec.js'),
            path.join('!' + conf.paths.src, '/app/**/*.mock.js'),
        ]);

    var injectScripts = $.mergeStream(_livescripts, _javascripts)
        .pipe(jsonFilter)
        // .pipe($.debug())
        .pipe($.angularFilesort()).on('error', conf.errorHandler('AngularFilesort'))
        .pipe(jsonFilter.restore)
        // .pipe($.debug());


    var injectOptions = {
        ignorePath  : [conf.paths.src, path.join(conf.paths.tmp, '/serve')],
        addRootSlash: false
    };

    return gulp.src(path.join(conf.paths.src, '/*.html'))
        .pipe($.inject(injectStyles, injectOptions))
        .pipe($.inject(injectScripts, injectOptions))
        .pipe(wiredep(_.extend({}, conf.wiredep)))
        .pipe(gulp.dest(path.join(conf.paths.tmp, '/serve')));
});
