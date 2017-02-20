# CAVC

[AtCoder Virtual Contest](https://not-522.appspot.com/)のコンテスト作成をコマンドでできるやつです。

現状、ABCとARCのみ対応しています。その他のコンテストには対応していません。

## Installation

たぶん以下のようにすればいいのではないでしょうか。

```
$ git clone https://github.com/ryoana14/cavc
$ cd cavc
$ rake install
```

## Usage

```
$ avc
Commands:
avc create          # create contest
avc help [COMMAND]  # Describe available commands or one specific command
```

`$HOME/.cavconfig`を以下のように作ってください。

```yaml
id: ryoana
password: hogehogefugafuga
```

`avc create`って叩けばあとはよしなに。

## Contributing

お願いします。

## License

[MIT License](http://opensource.org/licenses/MIT).

