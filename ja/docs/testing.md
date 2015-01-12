# テスト

** テストに関しては現在再検討中です。

Volt は最初から rspec と capybara を提供しています。モデルやコントローラーを直接テストすることもできますし、[Capybara](https://github.com/jnicklas/capybara) を使った結合テストも可能です。

Capybara でテストを実行するためには、ドライバーを指定する必要があります。現在、以下のドライバーをサポートしています。

1. Phantom (poltergeist 経由で利用する)

```BROWSER=phantom bundle exec rspec```

2. Firefox

```BROWSER=firefox bundle exec rspec```

3. IE - coming soon

Chrome は、ChromeDriver に関する[この問題](https://code.google.com/p/chromedriver/issues/detail?id=887#makechanges) が存在するため、サポートしていません。[このページ](https://code.google.com/p/chromedriver/issues/detail?id=887#makechanges)から、修正してくれるように chromedriver チームにアピールをお願いします！
