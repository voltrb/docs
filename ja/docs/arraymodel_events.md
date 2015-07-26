## ArrayModel イベント

ArrayModel はデータが更新されたときにイベントをトリガーします。現在、モデルは ```added``` と ```removed``` の2つのイベントを発生させます。例:

```ruby
page._items.on('added') { puts 'item added' }
page._items << 1
# => item 追加

page._items.on('removed') { puts 'item removed' }
page._items.delete_at(0)
# => item 削除
```

イベントはバインディングにおいて内部的に利用されるものですが、自分のコードで使うことも可能です。

で修正されましたt {{ file.mtime }}
