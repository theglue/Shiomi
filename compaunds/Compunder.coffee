AbstractValidator = require "shiomi/core/validators/AbstractValidator"


class Compunder extends AbstractValidator

  validators : null

  constructor:(validators...)->
    this.validators = []
    console.log validators


  ###*
    バリデーションを実行する
    @method toJS
  ###
  toJS:(val)=>
    vali.toJS(val) for vali in this.validators
    return


module.exports = Compunder