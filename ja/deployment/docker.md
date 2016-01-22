## Volt の Docker コンテナ

Volt アプリケーションに Dockerfile を作成し、以下を記載してください。

```
FROM otzy007/voltframework

RUN apt-get update
RUN apt-get install --yes nodejs
```

これで、Docker イメージをビルドすることができます。

```
docker build -t my-volt-app .
```

以下のように起動します。

```
docker run --name my-volt-app -p 3000:3000 -d my-volt-app
```

Web ブラウザーで http://localhost:3000 にアクセスできます。
