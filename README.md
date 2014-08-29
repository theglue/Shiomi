Shiomi
=======

ばりでーたー
そのうちビルドしたやつ置くから…


Usage
-------


CoffeeScript
```coffeescript

count = "（｀ェ´）ﾋﾟｬｰ"

validator = new IntValidator
try
  validator.toJS count
catch e
  console.log e #valid
```


```coffeescript

class HogeSchema extends Schema
  kls: HogeSchema
  @DDL:
    username: new RegexValidator
      regex: /[\w]+/ig
    mail: new MailValidator()

    bio: new StringValidator
      isRequire: false

Schema.extends HogeSchema

schema = new HogeSchema()

data = 
  username: "▂▅▇█▓▒░('ω')░▒▓█▇▅▂うわあああああああ"
  mail: "▂▅▇█▓▒░('ω')░▒▓█▇▅▂うわあああああああ"
  bio: ""

result = schema.validate data
unless result
  console.log schema.messages #いっぱいでてる
```