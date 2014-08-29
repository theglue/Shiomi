class AbstractValidator


  #エラーを入れる
  messages: []

  #識別子
  propName: null

  errorDispatchable: true

  validated: false


  ###*
    バリデーターの機関クラス
    @class AbsatractValidator
  ###
  constructor: (options = {}) ->
    sake.extend this, {}, options
    this.messages = []


  ###*
    バリデーションを実行する
    @method toJS
  ###
  toJS: (val) ->
    throw new Error("not implementing.")


  _execError: ->
    throw new Error("not implementing.")


module.exports = AbstractValidator