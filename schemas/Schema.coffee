AbstractValidator = require "shiomi/core/validators/AbstractValidator"
InValid           = require "shiomi/errors/InValid"


class Schema

  #データ構造
  @DDL: null

  @kls: Schema

  @propNames: {}

  _validators: {}

  #バリデーションが全部通過したかどうか
  passed: false

  messages : []

  ###*
    バリデーション構造体
    @class BaseSchema
  ###
  constructor: (options) ->
    sake.extend this, {}, options
    this._initialize()
    this.messages = []


  ###*
    初期化する
    @method _initialize
    @private
  ###
  _initialize: =>
    this._bindDDL()
    return


  ###*
    データ構造をバインドする
    @method _bindDDL
    @private
  ###
  _bindDDL: =>
    ddl = this.kls.DDL
    for prop of ddl
      #バリデーターでなければ弾く
      continue if not ddl[prop] instanceof AbstractValidator
      validator = ddl[prop]
      validator.propName = prop
      validator.errorDispatchable = false
      this.kls.propNames[prop] = validator
    return


  ###*
    バリデーションを実行する
    @methnod validate
    @param data {Object} バリデーションしたいデータ構造体
  ###
  validate: (data) =>
    #プロパティに対応したバリデーターを取ってくる
    this.messages = []
    for prop of data
      validator = this.kls.propNames[prop]
      if validator and validator instanceof AbstractValidator
        result = validator.toJS data[prop]
        this.messages = this.messages.concat validator.messages
    for prop of this.kls.propNames
      validator = this.kls.propNames[prop]
      #必須になっているがチェックされていないもの == data に含まれていない == 未入力チェック
      this.messages.push new InValid(prop, "empty") if validator.isRequired and not validator.validated
      #ついでにリセット
      validator.reset()
    if this.messages.length > 0
      return false
    return true


  ###*
    ターゲットとなるクラスに
    このクラスが保持するクラスメソッドを実装する
  ###
  @extends: (kls) ->
    props = sake.getPropNames this
    props = sake.diff(props, sake.objProps)

    for name in props
      kls[name] = this[name] if typeof this[name] is "function" and name not in kls
    return


module.exports = Schema