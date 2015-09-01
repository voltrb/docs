# アセット

## CSS/JavaScript

Volt では、JavaScript や CSS (または sass) といったアセットは、デフォルトでは、自動的にページにインクルードされるようになっています。asset/js や assets/css フォルダーに格納されたコンポーネントの中のものはすべて、([Sprockets](https://github.com/sstephenson/sprockets) を介して) /assets/{js,css} としてサーブされます。/assets/css や /assets/js に格納されている css や js のファイルそれぞれに対して、link や script タグが自動的に追加されます。y.  ファイルはその並び順通りに読み込まれるので、読み込み順を変更したい場合にはファイル名の先頭に数値を付けてください。

インクルードされたコンポーネントやコンポーネントの gem が持っているすべての JS/CSS も同様にインクルードされます。デフォルトで、 [bootstrap](http://getbootstrap.com/) が volt-bootstrap gem により提供されています。

### アセットの自動インポートを無効にする
もし、読み込まれる CSS や JS のアセットを手動で指定したい場合は、コンポーネントごとに ```config/dependencies.rb``` の先頭に ```disable_auto_import``` を設定してください。そうしておけば、以下のヘルパーを利用してコンポーネントの CSS や JS を手動で読み込むことができます。

```disable_auto_import``` は JS と CSS にのみ影響します。フォントや画像などのその他のアセットに対しては効果がありません。

例えば、```config/dependencies.rb``` が以下の内容であったとします:

```
disable_auto_import
css_file 'manifest.scss'
# font awesome
css_file '//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css'
javascript_file 'my_js.min.js'
```
このとき、FontAwesome の CDN へのリンクである 'manifest.scss' と、'my_js.min.js' だけが読み込まれます。

##### javascript_file
```javascript_file 'my_js.js'```
このヘルパーは、```app/{component}/assets/js``` 以下のファイルを探索します。

##### css_file
```css_file 'my_scss.scss'```
このヘルパーは、```app/{component}/assets/css``` 以下のファイルを探索します。SCSS と CSS でこれを利用することができます。これを利用する場合、CSS/SCSS が読み込まれる順序を指定するためにマニフェストファイルを作成することができます。

## 画像/フォント/その他のアセット

画像やその他のアセットは```app/{component}/assets/images``` (又は fonts など) に配置することを勧めます。そうすると、例えば画像のURLは```/assets/{component}/assets/images/...```の様になります. ```disable_auto_import``` は画像やその他のアセットに対しては無効です。

**メモ: アセットバンドルについては検討中です**
