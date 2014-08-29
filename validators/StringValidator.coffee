BasicValidator = require "shiomi/validators/BasicValidator"


class StringValidator extends BasicValidator

  ###*
    文字かどうかチェックする
    @class IntValidator
    @extends BasicValidator
  ###
  constructor:(options={})->
    super(options)



  ###*
    バリデーションを実行する
    @method toJS
    @param val
  ###
  toJS: (val) =>
    super(val)
    #文字じゃなかったら返す
    unless typeof val is "string"
      #badtype
      this.messages.push new InValid(this.propName, 'str')
    else if this.max or this.min
      len = val.length
      if this.max and len > this.max
        #toolong
        this.messages.push new InValid(this.propName, 'max')

      if this.min and len < this.min
        #tooShort
        this.messages.push new InValid(this.propName, 'min')

    this._execError()
    return val


module.exports = StringValidator