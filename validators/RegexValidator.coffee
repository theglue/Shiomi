StringValidator = require "/shiomi/validators/StringValidator"
InValid = require "shiomi/errors/InValid"


class RegexValidator extends StringValidator

  regex : null

  ###*
    正規表現を実行する
    @class RegexValidator
    @extends StringValidator
  ###
  constructor:(options={})->
    unless options.hasOwnProperty "regex"
      throw new Error("require regex.")

    #正規表現パターンじゃなければエラー
    unless options.regex instanceof RegExp
      throw new Error("param is not RegExp")
    super(options)


  ###*
    バリデーションを実行する
    @method toJS
    @param val
  ###
  toJS:(val)=>
    super(val)

    result = null
    #文字列チェックは StringValidator の方でやってあるけど
    #エラーをスルーするタイミングの問題。
    if typeof val is "string"
      result = val.match(this.regex)
    this.messages.push new InValid(this.propName) unless result
      #not match.
      

    this._execError()
    return result


module.exports = RegexValidator