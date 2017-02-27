var gulp = require('gulp'),
    apidoc = require('gulp-apidoc');

gulp.task('apidoc', function(done) {
  apidoc({
      src: "./",
      dest: "doc/api/",
      template: "node_modules/apidoc/template/",
      debug: false,
      includeFilters: [ ".*\\.ls$" ]
  }, done);
});
