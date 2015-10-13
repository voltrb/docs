# ファイルの require

もし、`my_awesome_app` がアプリケーションのルートであったとして、`my_awesome_app/app/main/mixins/my_file.rb` というファイルがあって、`main` がコンポーネントである場合、他のファイルからは以下のようにして require することができます。

```ruby
require "main/mixins/my_file"
```

つまり、コンポーネントのフォルダからのパスとなります。
