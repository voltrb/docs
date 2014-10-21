# -- WORK IN PROGRESS --

# チュートリアル

ここでは、Volt で基本的な Web アプリケーションを作成する手順を示します。 このチュートリアルは、Ruby と Web 開発の基本的な知識を持っていることを前提とします。

## セットアップ

最初に、Volt をインストールして空のアプリケーションを作成しましょう。Ruby (>2.1.0) と rubygems がインストールされていることを確認してください。

次に、Volt の gem をインストールします:

    gem install volt

Volt の gem を使って新しいプロジェクトを作成します:

    volt new sample_project

これで sample_project フォルダーに基本的なプロジェクトがセットアップされます。```cd``` コマンドでそのフォルダーに移動し、サーバーを起動します:

    bundle exec volt server

Voltのコンソールには以下でアクセスすることができます:

    bundle exec volt console

