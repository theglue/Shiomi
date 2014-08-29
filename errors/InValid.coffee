Shiomi = require "shiomi/Shiomi"


class InValid

  msg: null

  #識別子
  propName: null

  ###*
    バリデーションエラー
    @class InValid
  ###
  constructor: (@propName, @msgType) ->
    this.msg = Shiomi.getMsg @msgType


module.exports = InValid