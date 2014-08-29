BasicValidator = require "shiomi/validators/BasicValidator"


class BoolValidator extends BasicValidator


  ###*
    True か False かを判定する
    @class BoolValidator
    @method BoolValidator
    @constructor
  ###
  constructor:(options={})->
    super(options)


  ###*
    バリデーションを実行する
    @method toJS
    @param val {String} バリデーションしたい値
    @return {String} バリデーション後の文字列
  ###
  toJS:(val)=>
    super(val)

    if typeof val is "string"
      val = this._stringValidate val
    else if typeof val is "number"
      val = this._numberValidate val
    else if val instanceof Array
      val = this._arrayValidate val
    else if typeof val is "object"
      #Object はチェック基準が多すぎるのでとりあえず false
      val = false

    this._execError()
    return val


  ###*
    文字列から
    @method _stringValidate
    @private
    @param val {String} チェックしたい文字列
    @return Boolean 結果
  ###
  _stringValidate:(val)=>
    #小文字に揃える
    val = val.toLowerCase()
    if val is ''
      return false

    #1 か true の文字列だったら true
    if val is 'true' or val is '1'
      return true
    return false


  ###*
    数字だった
    @method _numberValidate
    @private
    @param val {Array}
    @return Boolean 結果
  ###
  _numberValidate: (val) =>
    #1だったら true
    if val is 1
      return true
    return false


  ###*
    array
  ###
  _arrayValidate: (val) =>
    if this._arrayValidate.length < 1
      return false
    return true


module.exports = BoolValidator