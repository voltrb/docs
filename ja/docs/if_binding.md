# If バインディング

```if``` バインディングは、基本的な制御文を提供します。

```html
{{ if some_check?}}
  <p>render this</p>
{{ end }}
```

ブロックは ```{{ end }}``` で閉じます。

```if``` バインディングがレンダリングされるときは、「if」 に続く Ruby コードが実行されます。そして、そのコードが真である場合にのみ、後続のコードがレンダリングされます。```if``` 条件に含まれるデータの変更はすべて、レンダリングされるブロックを更新します。

また、If バインディングは ```elsif``` と ```else``` ブロックを持つことができます。

```html
{{ if condition_1?}}
  <p>condition 1 true</p>
{{ elsif condition_2?}}
  <p>condition 2 true</p>
{{ else }}
  <p>neither true</p>
{{ end }}
```

## unless

unless もサポートしています。

```html
{{ unless some_check?}}
  <p>render this when some_check?is false</p>
{{ end }}
```

で修正されましたt {{ file.mtime }}
