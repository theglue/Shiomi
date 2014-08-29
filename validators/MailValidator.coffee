StringValidator = require "shiomi/validators/StringValidator"
InValid = require "shiomi/errors/InValid"


class MailValidator extends StringValidator

  @USER_NAME_RE: /^[\w!#$%&'*+\-\/=?^`{|}~.]+$/

  @DOMAIN_RE: /^([a-zA-Z0-9_-]+\.)+[a-zA-Z]{2,4}$/ig


  constructor: (options={}) ->

    #dummy and kill
    options.regex = /hoge/
    super(options)


  ###*
    バリデーションを実行する
    @method toJS
    @param val {String} 文字列
    @return val {String} バリデーション済みの Email アドレス
  ###
  toJS: (val) =>
    super(val)

    unless typeof val is "string"
      this._execError()
      return val

    attrs    = val.split("@")

    #@入ってない
    if attrs.length is 1
      this.messages.push new InValid(this.propName, "email")
      return val

    if val.match(/@/g).length > 1
      this.messages.push new InValid(this.propName, "email")
      return val

    if attrs.length isnt 2
      #invalid email address
      this.messages.push new InValid(this.propName, "email")
      return val
    username = attrs[0]
    domain   = attrs[1]

    if not username.match(MailValidator.USER_NAME_RE) or not domain.match(MailValidator.DOMAIN_RE)
      #invalid email address
      this.messages.push new InValid(@propName, "email")
    this._execError()
    return val


module.exports = MailValidator