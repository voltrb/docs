# テスト

Voltのテストは、デフォルトでRspecを使用しますが、プロジェクトのGemfileからRspec関連のgemを削除することで、別のテストフレームワークを利用することも可能です。ほとんどのジェネレーターはスタブのspecを生成するため、テストを始めやすくなっています。

Voltプロジェクトの規約では、specディレクトリの中にappディレクトリのミラーを用意します。したがって、コンポーネントはそれぞれspecの中にフォルダを持つことになります。もし ```require 'spec-helper'``` をspecファイルに記載していれば、```bundle exec rspec``` によってすべてのテストを実行できます。また、特定のspecのパスを指定することも可能です。(注意: Voltは初期状態ではrakeを利用しません。したがって、通常は直接rspecを実行します。)

# ヘルパー

Voltは、spec内で ```page``` と ```store``` コレクションにアクセスするためのメソッドを提供しています。名前がCapybaraで定義されているものと被らないように、rspecでは```page```は```the_page```とします (コンフリクトを回避するための方法を検討中です)。

spec内で```store``` にアクセスする場合には ```store``` を使用します。```store``` が呼び出された場合、specが実行された後にデータベースはクリアされます。これによって、実際にstoreを利用している場合を除いては、specごとにデータベースの準備を行う必要がなくなります。

# インテグレーションspec

Volt は最初から rspec と capybara を提供しています。モデルやコントローラーを直接テストすることもできますし、[Capybara](https://github.com/jnicklas/capybara) を使った結合テストも可能です。

Capybaraでspecを実行したい場合は、describeブロックに```type: :feature``` を追加します。

```ruby
describe "browser specs", type: :feature do
  it ...
end
```

インテグレーションテストはデフォルトでは動作しません。Capybaraのテストを実行する場合は、ドライバーを指定する必要があります。現在、以下のドライバーをサポートしています。

1. Phantom (poltergeist 経由で利用する)

```BROWSER=phantom bundle exec rspec```

2. Firefox

```BROWSER=firefox bundle exec rspec```

3. IE - coming soon

Chrome は、ChromeDriver に関する[この問題](https://code.google.com/p/chromedriver/issues/detail?id=887#makechanges) が存在するため、サポートしていません。[このページ](https://code.google.com/p/chromedriver/issues/detail?id=887#makechanges)から、修正してくれるように chromedriver チームにアピールをお願いします！

で修正されましたt {{ file.mtime }}
