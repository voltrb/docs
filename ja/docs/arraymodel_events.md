## ArrayModel イベント

モデルはデータが更新されたときにイベントをトリガーします。現在、モデルは added と removed の2つのイベントを発生させます。例:

```ruby
    model = Volt::Model.new

    model._items.on('added') { puts 'item added' }
    model._items << 1
    # => item added

    model._items.on('removed') { puts 'item removed' }
    model._items.delete_at(0)
    # => item removed
```
