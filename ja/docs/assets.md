# アセット

**注意: アセット管理については今後変更される可能性があります。**

## CSS/JavaScript

Volt では、JavaScript や CSS (または sass) といったアセットは、自動的にページにインクルードされます。asset/js や assets/css フォルダーに格納されたコンポーネントはすべて、([Sprockets](https://github.com/sstephenson/sprockets) を介して) /assets/{js,css} としてサーブされます。/assets/css や /assets/js に格納されている css や js のファイルそれぞれに対して、link や script タグが自動的に追加されます。y.  ファイルはその並び順通りに読み込まれるので、読み込み順を変更したい場合にはファイル名の先頭に数値を付けてください。

インクルードされたコンポーネントやコンポーネントの gem が持っているすべての JS/CSS も同様にインクルードされます。デフォルトで、 [bootstrap](http://getbootstrap.com/) が volt-bootstrap gem により提供されています。

## 画像/フォント/その他のアセット

It is reccomended that images and other assets be put in ```app/{component}/assets/images``` (or fonts, etc..)  Then the url for an image for example would be: ```/assets/{component}/assets/images/...```

**メモ: アセットバンドルについては検討中です**

で修正されましたt {{ file.mtime }}
