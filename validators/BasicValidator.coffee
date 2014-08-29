AbstractValidator = require "shiomi/core/validators/AbstractValidator"
InValid = require 'shiomi/errors/InValid'


class BasicValidator extends AbstractValidator

  #必須
  isRequire : true

  #null を許容するかどうか
  isNotNull : true

  #最大値
  max : null

  #最小値
  min : null

  ###*
    ベーシックなバリデータークラス
    @class BaseValidator
    @constructo
  ###
  constructor: (options={}) ->
    super(options)


  ###*
    バリデーションを実行する
    @method toJS
    @param val バリデーションしたいターゲット
    @return result バリデーションした結果
  ###
  toJS: (val) =>
    this.messages.push new InValid(this.propName, "empty") if not val and this.isRequire
    this.messages.push new InValid(this.propName, "empty") if val is null and this.isNotNull
    this._lengthCheck(val) if typeof val is "number" or typeof val is "array"

    this.validated = true
    return val


  ###*
    初期化する
    @metnod reset
  ###
  reset: =>
    this.validated = false
    this.messages = []
    return


  ###*
    エラーメッセージが入ってたらエラーを投げる
    @method _execError
    @protected
  ###
  _execError: =>
    unless this.errorDispatchable
      return this.messages
    if this.messages.length > 0
      throw new Error("validation faild.")
    return this.messages


  ###*
    長さチェック
  ###
  _lengthCheck: (val) =>
    this.messages.push new InValid(this.propName, "max") if this.max and this.max < val
      #okkikatta-
    this.messages.push new InValid(this.propName, "min") if this.min and this.min > val
      #ちっちゃかった―
    return


module.exports = BasicValidator