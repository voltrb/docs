# パーミッション

デフォルトでは、Volt のモデルに対して誰でも読み書きすることができますが、モデルに対する読み書きを制限することは簡単です。パーミッションの操作は、Volt のパーミッション API によって、create/read/update/delete (CRUD) の4つのアクションに分類することができます。

以下のようにして、モデルクラスにおいてパーミッションを指定します。

```ruby
class Todo < Volt::Model

    permissions do
      # .. permissions logic ..
    end
end
```
## パーミッションの働き

この permissions ブロックはモデルに対していずれかの CRUD 操作が行われた場合に常に呼び出されます。permissions ブロックの内部では、パーミッションを制限するために ```allow``` と ```deny``` を利用できます。それらを引数なしで実行すると、すべてのアクションが制限されます。引数にフィールド名のリストを渡すことも可能です。その場合、それらのフィールドのみが制限されます。permissions ブロックの中で、```self``` は現在のモデルを指します。

```ruby
class Todo < Volt::Model
  permissions do
    deny :label
  end
end
```

permissions ブロックの最後の値 (暗黙的な戻り値) が Promise である場合、後続処理を実行する前に permissions ブロックを解決します。(したがって、permissions  ブロックの中で他のモデルの問い合わせを行うことが可能で、.then によって新しい promise を返すことができます)

```ruby
class Todo < Volt::Model
  permissions do
    # Volt.current_user returns a promsie that resolves the current user, we
    # then return a new promise that checks the admin state and denies unless
    # the user is an admin.
    Volt.current_user.then do |user|
      deny unless user.admin?
    end
  end
end

```

## Own by User

```own_by_user``` メソッドを利用すると、モデルが生成され、ユーザーがログインしている場合には ```user_id``` フィールドをアサインすることが可能です (詳しくは [ユーザー](http://docs.voltframework.com/en/docs/users.html)を参照してください)。そのとき、自動的に :user への belong_to 関連が設定されます (```user_id``` に別のキーを指定することも可能です)。

ユーザーがモデルのオーナーである場合は、現在ログインしているユーザーがオーナーであるかどうかを、permissions ブロック内で ```.owner?``` を実行することで確認することができます。もし現在のユーザーがオーナーであれば、true を返します。

```ruby
class Todo < Volt::Model
  own_by_user

  permissions do
    deny unless owner?
  end
end
```

※上記の場合、オーナー以外はこのモデルに対して read/create/update/delete の操作すべてが禁止されます。(create では ```.owner?``` は true となります。なぜなら、```own_by_user``` が ```user_id``` をアサインするからです)

### Allow VS Deny

もし1つでも allow が指定されると、他のフィールドはすべて deny として扱われます。deny は allow を上書きします。

```ruby
class Todo < Volt::Model
  permissions do
    allow :label, :complete
  end
end
```

※label と complete のみが allow で、その他はすべてブロックされます。引数なしで ```permissions``` を利用すると、すべての CRUD 操作に対してパーミッションが設定されます。ある特定のアクションのみにパーミッションを指定したい場合には、アクションに対応するシンボルを ```permission``` メソッドの引数に指定してください。複数の permissions ブロックを指定することも可能です。

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

※上記では、```notes``` と ```secret_notes``` を変更することができるのはオーナーだけですが、他のフィールドは誰でも変更することが可能です。また、```secret_notes``` を読むことができるのはオーナーのみです (他のすべてのフィールドは誰でも読むことが可能です)。そして、モデルを削除できるはオーナーだけです。

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

パーミッション API によって、アプリケーションのデータに対して「誰が」「何を」できるのかをシンプルな方法で設定することが可能です。また、permissions ブロック内にはどんなロジックでも書くことができます。

