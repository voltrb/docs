# パーミッション

デフォルトでは、Voltのモデルに対して誰でも読み書きすることができますが、モデルに対する読み書きを制限することは簡単です。パーミッションの操作は、VoltのパーミッションAPIによって、create/read/update/delete (CRUD) の4つのアクションに分類することができます。

以下のようにして、モデルクラスにおいてパーミッションを指定します。

```ruby
class Todo < Volt::Model

    permissions do
      # .. permissions logic ..
    end
end
```
## Permission Logic

このpermissionsブロックはモデルに対していずれかのCRUD操作が行われた場合に常に呼び出されます。permissionsブロックの内部では、パーミッションを制限するために```allow```と```deny```を利用できます。それらを引数なしで実行すると、すべてのアクションが制限されます。引数にフィールド名のリストを渡すことも可能です。その場合、それらのフィールドのみが制限されます。permissionsブロックの中で、```self```は現在のモデルを指します。

```ruby
class Todo < Volt::Model
  permissions do
    deny :label
  end
end
```

## own_by_user

```own_by_user```メソッドを利用すると、モデルが生成され、ユーザーがログインしている場合には```user_id```フィールドをアサインすることが可能です (詳しくは [ユーザー](http://docs.voltframework.com/en/docs/users.html)を参照してください)。そのとき、自動的に :user への belong_to 関連が設定されます (```user_id``` に別のキーを指定することも可能です)。

ユーザーがモデルのオーナーである場合は、現在ログインしているユーザーがオーナーであるかどうかを、permissionsブロック内で```.owner?```を実行することで確認することができます。もし現在のユーザーがオーナーであれば、trueを返します。

```ruby
class Todo < Volt::Model
  own_by_user

  permissions do
    deny unless owner?
  end
end
```

^ 上記の場合、オーナー以外はこのモデルに対してread/create/update/deleteの操作すべてが禁止されます。(createでは```.owner?``` はtrueとなります。なぜなら、```own_by_user``` が ```user_id```をアサインするからです)

### Allow vs Deny

もし1つでもallowが指定されると、他のフィールドはすべてdenyとして扱われます。denyはallowを上書きします。

```ruby
class Todo < Volt::Model
  permissions do
    allow :label, :complete
  end
end
```

^ allowとcompleteのみがallowで、その他はすべてブロックされます。引数なしで```permissions```を利用すると、すべてのCRUD操作に対してパーミッションが設定されます。ある特定のアクションのみにパーミッションを指定したい場合には、アクションに対応するシンボルを```permission```メソッドの引数に指定してください。複数のpermissionsブロックを指定することも可能です。

```ruby
class Todo < Volt::Model
  permissions(:create, :update) do
    deny :notes, :secret_notes unless owner?
  end

  permissions(:read) do
    deny :secret_notes unless owner?
  end

  permissions(:delete) do
    deny unless owner?
  end
end
```

^ 上記では、```notes``` と ```secret_notes``` を変更することができるのはオーナーだけですが、他のフィールドは誰でも変更することが可能です。また、```secret_notes``` を読むことができるのはオーナーのみです (他のすべてのフィールドは誰でも読むことが可能です)。そして、モデルを削除できるはオーナーだけです。

### アクションを渡す

permissionsブロックにはアクションを渡すことも可能です。実行されているアクションを示すシンボルが渡されます。

```ruby
class Todo < Volt::Model
  permissions(:read, :update) do |action|
    if action == :read
        allow
    else
        deny unless owner?
    end
  end
end
```

### パーミッションのスキップ

パーミッションの複雑なロジックを構成することなく、もっと単純に、変更できないデータを設定しておき、タスクからのみ変更できるようにすることが可能です。例えば、ユーザーモデルに ```admin``` フラグを設定する場合などが例としてあげられるでしょう。そのためには、```admin``` に対する更新を禁止しておいて、手動でパーミッションのスキップを指定します。

```ruby
class User < Volt::User
  permissions(:create, :update) do
    # このようにすることで、パーミッションのスキップなしでは誰も更新できません
    deny :admin
  end
end
```

パーミションのスキップは ```Volt.skip_permissions``` にブロックを指定して実行することで指定します。言うまでもないですが、 ```skip_permissions``` はサーバー側でのみ有効です。

```ruby
Volt.skip_permissions do
  # パーミションのチェックをしない
  # admin をセット
  user._admin = true
end
```
### まとめ

パーミッションAPIによって、アプリケーションのデータに対して「誰が」「何を」できるのかをシンプルな方法で設定することが可能です。また、permissionsブロック内にはどんなロジックでも書くことができます。


で修正されましたt {{ file.mtime }}
