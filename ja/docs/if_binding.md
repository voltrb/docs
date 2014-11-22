# If バインディング

If バインディングは、基本的な制御文を提供します。

```html
{{ if _some_check?}}
  <p>render this</p>
{{ end }}
```

ブロックは ```{{ end }}``` で閉じます。

If バインディングがレンダリングされるときは、if に続く Ruby コードが実行されます。そして、そのコードが真の場合にのみ後続のコードがレンダリングされます。このとき、分岐条件に対して変更があったときには、それに伴い表示される内容が更新されます。

また、If バインディングは ```elsif``` と ```else``` ブロックを持つことができます。

```html
{{ if _condition_1?}}
  <p>condition 1 true</p>
{{ elsif _condition_2?}}
  <p>condition 2 true</p>
{{ else }}
  <p>neither true</p>
{{ end }}
```
