# タグの引数と属性

他の html タグと同様に、コントロールには属性を指定することができます。指定した属性はオブジェクトに変換され、コントローラーの initialize メソッドの第一引数として渡されます。標準的な Volt::ModelController の initialize は、そのオブジェクトを ```#attrs``` でアクセス可能なプロパティに代入します。これによって指定した属性へ容易にアクセスすることが可能になっています。

```html

<:Body>

  <ul>
    {{ _todos.each do |todo| }}
      <:todo name="{{ todo._name }}" />
    {{ end }}
  </ul>

<:Todo>
  <li>{{ attrs.name }}</li>
```

属性を個別に指定する代わりに、「model」属性に Volt::Model オブジェクトを指定することもできます。そのモデルはコントローラーの利用するモデルとして設定されます。

```html
<:Body>
  <ul>
    {{ _todos.each do |todo| }}
      <:todo model="{{ todo }}" />
    {{ end }}
  </ul>

<:Todo>
  <li>
    {{ _name }} -
    {{ if _complete }}
      Complete
    {{ end }}
  </li>
```
