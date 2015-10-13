# Flash コレクション

Flash コレクションを使うと、クライアント側のユーザーに対して簡単に情報を表示することができます。Flash は (デフォルトで) ```successes```、```notices```、```warnings```、そして ```errors``` と 4種類の ArrayModel を含んでいます。これらのコレクションが追加されたとき、```"alert alert-{{ ..コレクション名..}}"``` というクラスの div 要素にメッセージが表示されます。

### 例

```ruby
flash._successes << "Your data has been saved"
```

```ruby
flash._errors << "Unable to save because your not on the internet"
```

Flash のサブコレクションに追加された文字列は、5秒後に削除されます。デフォルトでは、クリックすることで flash メッセージを消すことも可能です。

# Local Store コレクション

```local_store``` コレクションは、データをブラウザーのローカルストレージに永続化します。

# Cookies コレクション

```cookies``` コレクションは、データをブラウザーの cookie に保存します。割り当てられたプロパティはそれぞれ、同盟の cookie に保存されます:

```ruby
cookies._user_id = 520

puts cookie._user_id
# => "520"

cookies.delete(:user_id)
```

Cookie コレクションでは、値は文字列に変換されます。説明の追加などのオプション機能については todo 項目としてあがっています。現在のところ、cookie の有効期間は1年間に設定されています。


