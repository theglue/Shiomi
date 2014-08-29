BasicValidator = require "shiomi/validators/BasicValidator"
InValid = require "shiomi/errors/InValid"


class NumberValidator extends BasicValidator

  ###*
    数字かどうかチェックする
    @class NumberValidator
    @extends BaseValidator
  ###
  constructor:(options={})->
    super(options)


  ###*
    バリデーションを実行する
    @method toJS
    @param {Number},{String} チェックしたい値。文字列か Number
  ###
  toJS: (val) =>
    if typeof val is "string"
      try
        val = parseFloat(val, 10)
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

    #エラーメッセージがあればエラー出力
    this._execError()
    return val


module.exports = NumberValidator