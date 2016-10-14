var gulp = require('gulp');
var plugins = require('gulp-load-plugins')();

gulp.task('minifyJs',function(){
    return gulp.src('resources/**/*.js')
        .pipe(plugins.uglify())
        .pipe(plugins.rev())                        //����10λ�����hashֵ
        .pipe(gulp.dest('resources'))                      //����޸����ƺ���ļ�
        .pipe(plugins.rev.manifest())               //���������ļ���Ӧ�ļ�ֵ��
        .pipe(gulp.dest('gulp'))                  //��ֵ�����

})
gulp.task('htmlRouter',function() {
    return gulp.src(['gulp/*.json','WEB-INF/page/*.jsp','WEB-INF/page/**/*.jsp'])      //
        .pipe(plugins.revCollector())                //�滻������ļ������޸����ƺ���ļ�����
        .pipe(gulp.dest('WEB-INF/page'))
})

