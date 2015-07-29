# Voltとは

Volt は Ruby の Web フレームワークで、サーバーサイドとクライアントサイドの両方のコードを Ruby で記述できることが特徴です。(クライアント側では [opal](https://github.com/opal/opal) を利用します)。Volt では、ユーザーがページに対して行った操作に応じて自動的に DOM が更新されます。また、ページの状態を URL として保持することができます。ユーザーが URL に直接アクセスした場合、HTML はまずサーバー上でレンダリングされます。これはロード時間の高速化や、検索エンジンによるインデックス化を容易にするためです。そして、クライアント側に保持されます。

Volt では、HTTP を介してクライアントとサーバー間のデータを同期するのではなく、永続的なコネクションを利用します。したがって、ある1つのクライアント上でデータが更新されたときには、データベース、および他のリスニング中のクライアント上でも更新が行われます。(しかも、そのために設定を行う必要はありません)

ページの HTML はテンプレート言語で記述し、```{{``` と ```}}``` で囲むことで Ruby のコードを直接書くことができます。Volt は、DOM (および値が変更されたことを検知したい他のすべてのコード)に対して、自動的に、かつ正確に変更を伝えるために、データフロー／リアクティブプログラミングを利用します。 DOM に何らかの変更があった場合に、Volt は変更が必要なノードだけを正しく更新することができます。

文章のドキュメントだけでなく、デモビデオも用意しています。

- [Volt Todos Example](https://www.youtube.com/watch?v=KbFtIt7-ge8)
- [What Is Volt in 6 Minutes](https://www.youtube.com/watch?v=P27EPQ4ne7o)
- [Pagination Example](https://www.youtube.com/watch?v=1uanfzMLP9g)
- [Routes and Templates](https://www.youtube.com/watch?v=1yNMP3XR6jU)
- [Isomorphic App Development - RubyConf 2014](https://www.youtube.com/watch?v=7i6AL7Walc4)

デモアプリケーションも用意しています。
 - https://github.com/voltrb/todomvc
 - https://github.com/voltrb/blog5

