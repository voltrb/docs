# アセット

## CSS/JavaScript

Volt では、JavaScript や CSS (または sass) といったアセットは、デフォルトでは、自動的にページにインクルードされるようになっています。asset/js や assets/css フォルダーに格納されたコンポーネントの中のものはすべて、([Sprockets](https://github.com/sstephenson/sprockets) を介して) /assets/{js,css} としてサーブされます。/assets/css や /assets/js に格納されている css や js のファイルそれぞれに対して、link や script タグが自動的に追加されます。ファイルはその並び順通りに読み込まれるので、読み込み順を変更したい場合にはファイル名の先頭に数値を付けてください。

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

画像やその他のアセットは```app/{component}/assets/images``` (または fonts など) に配置することを勧めます。そうすると、production にデプロイするときアセットをプリコンパイルすることができ、Volt はファイルの内容の fingerprint (ファイルのハッシュ) をファイル名の末尾に付け加えます。このことによって、すべてのアセットを無期限にキャッシュすることが可能になります。(詳細は [デプロイ](deployment/README.md)を参照してください)

Volt の app フォルダは /app の URL にマウントされます。したがって、

```app/main/assets/images/profile.jpg``` というアセットには、```/app/main/assets/images/profile.jpg``` でアクセス可能です。ただ、一般的には、asset_path ヘルパーを使ってアセットを参照します。これらのヘルパーはプリコンパイルを行った際に URL を書き換え、様々なプリコンパイルの最適化を可能にします。

アセットパスの書き換えを有効にするには、CSS や HTML でアセットのパスを参照する箇所を変更する必要があります。

CSS/Sass では、単純に以下のように変更します。

```background-image: url(../images/something.png);``` を ```background-image: asset-url("../images/something.png");``` にする。

※クォートでくくるのを忘れないようにしてください。

HTML では、画像を直接参照するのではなく、以下のようにします。

```html
<img src="{{ asset_url('../../assets/images/something.png') }}" />
```

※asset_url を利用する場合は、レンダリングされる場所ではなく、.html ファイルからの相対パスを指定してください。以下の URL スキーマを使うこともできます。

```css
background-image: url(blog/assets/images/header.jpg);
```

上記の例では、app フォルダからの指定となっています。この場合、別のコンポーネントからアセットを利用することが可能です。
