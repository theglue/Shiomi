BasicValidator = require "shiomi/validators/BasicValidator"
InValid = require 'shiomi/errors/InValid'


class IntValidator extends BasicValidator

  ###*
    整数かどうかチェックする
    @class IntValidator
    @extends BaseValidator
  ###
  constructor:(options={})->
    super(options)


  ###*
    バリデーションを実行する
    @method toJS
    @parma val {Number} 整数
    @return バリデーション結果
  ###
  toJS: (val) =>
    try
      val = parseInt(val, 10)
      if not val and this.isRequire
        #未入力
        this.messages.push new InValid(this.propName, 'empty')
      if +val isnt +val and (this.isRequire and val isnt "")
        this.messages.push new InValid(this.propName, 'numeric')
    catch e
      #not Number
      this.messages.push new InValid(this.propName, 'numeric')
    #Number に関連しない型だったらこの場で返す
    if typeof val isnt "number"
      #badType
      this.messages.push new InValid(this.propName, 'numeric')
      return val
    super(val)

    this._execError()
    return


module.exports = IntValidator