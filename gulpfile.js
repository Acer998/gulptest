var gulp = require('gulp');
var plugins = require('gulp-load-plugins')();

gulp.task('minifyJs',function(){
    return gulp.src('resources/**/*.js')
        .pipe(plugins.uglify())
        .pipe(plugins.rev())                        //增加10位的随机hash值
        .pipe(gulp.dest('resources'))                      //输出修改名称后的文件
        .pipe(plugins.rev.manifest())               //将生成与文件对应的键值对
        .pipe(gulp.dest('gulp'))                  //键值对输出

})
gulp.task('htmlRouter',function() {
    return gulp.src(['gulp/*.json','WEB-INF/page/*.jsp','WEB-INF/page/**/*.jsp'])      //
        .pipe(plugins.revCollector())                //替换引入的文件，将修改名称后的文件引入
        .pipe(gulp.dest('WEB-INF/page'))
})

