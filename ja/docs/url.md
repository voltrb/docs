# Url

Volt では、URL 情報にアクセスしたい場合、コントローラー上で使うことができる```url``` メソッドを利用します。url は以下のメソッドを持っています。それぞれ、現在のところは getter のみです (setter も近くサポートする予定)。

- scheme
- host
- port
- path
- query
- fragment

それぞれのメソッドは url の変更にしたがってリアクティブに更新されます。
