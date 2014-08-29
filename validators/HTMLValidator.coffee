BasicValidator = require "shiomi/validators/BasicValidator"
InValid = require 'shiomi/errors/InValid'


class HTMLValidator extends BasicValidator

  tagExp = /<("[^"]*"|'[^']*'|[^'">])*>/ig

  ###*
    HTML が含まれているかどうかをチェックする
    @class HTMLValidator
    @method HTMLValidator
    @constructor
  ###
  constructor: (options={}) ->
    super(options)


  ###*
    バリデーションを実行する
    @method toJS
    @param val {String} バリデーションしたい文字列
    @return {String} バリデーション済みの文字列
  ###
  toJS: (val) =>
    super(val)

    #文字列でなければ文字列にする?
    if typeof val isnt "string"
      val = String(val)

    result = val.match tagExp
    this.messages.push new InValid(this.propName, 'html') if result


    this._execError()
    return val


module.exports = BasicValidator