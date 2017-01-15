## rake taskについて
### rakeとは
> Rake は Make によく似た機能を持つ Ruby で書かれたシンプルなビルドツールです。

<http://docs.ruby-lang.org/ja/2.2.0/library/rake.html>

> 世間では、ビルドツールというとMakeやApache Antが有名で、よく使われている。 Rakeは、これらのいいとこ取りをした上で、特有のフィーチャーを追加した新しいビルドツールであり、複雑なビルドを柔軟に書きこなすことができる。その秘密は内部DSLという仕組みにあり、このおかげでビルドの記述にRubyの強力な文法をそのまま使うことができる。この自由度の高さは、ビルドの記述に独自の言語の使用を選択したMakeとAntには無い強みだ。

<http://www2s.biglobe.ne.jp/~idesaku/sss/tech/rake/>

簡単にまとめると, バッチ処理などをまとめておくもの  
/lib/tasks/*.rake のファイルの中に設定されている

### rake の使い方
* 利用できるrakeの一覧を見る

	$ rake -T

## 参照
[rubyのrakeの基礎](http://qiita.com/magaya0403/items/01c8bd7c281c31d1db0d)