RegexValidator = require "shiomi/validators/RegexValidator"


class KanaValidator extends RegexValidator

  regex : null

  ###*
    カナのみを受け付ける
    @class KanaValidator
    @extends StringValidator
  ###
  constructor:(options={})->
    options.regex = /^[ァ-ン]+$/ig
    super(options)


  ###*
    バリデーションを実行する
    @method toJS
    @param val
  ###
  toJS:(val)=>
    try
      super(val)
    catch e
      console.log e
    if this.messages.length > 0
      return val

    unless typeof val is "string"
      this._execError()
      return val
    return val


module.exports = KanaValidator