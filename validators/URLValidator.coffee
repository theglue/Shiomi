RegexValidator = require "shiomi/validators/RegexValidator"
InValid = require "shiomi/errors/InValid"


class URLValidator extends RegexValidator


  addHttp : false
  addHttps : false

  isExists : false

  # VAILD_URL : /([a-z0-9][a-z0-9\-]{2,62}\.)*([a-z]{2,63}|xn--[a-z0-9\-]{2,59})(?::[0-9]{1,5})?(\/[a-z0-9\-\._~:\?#\[\]@!%\$&\'\(\)\*\+,;=]*)?/ig

  # VAILD_URL: /([-._a-z\d]+\.[a-z]{2,4})([\w,.:;&=+*%$#!@()~\'\/-]*)\??([\w,.:;&=+*%$#!?@()~\'\/-]*)/
  VAILD_URL: /(http|https):\/\/([-._a-z\d]+\.[a-z]{2,4})([\w,.:;&=+*%$#!@()~\'\/-]*)\??([\w,.:;&=+*%$#!?@()~\'\/-]*)/
  constructor:(options={})->
    #dummy and kill
    options.regex = /[a-zA-Z0-9\-_\.:@!~*'\(¥);\/?&=\+$,%#]+/ig
    super(options)


  ###*
    バリデーションを実行する
    @method toJS
    @param val
    @return
  ###
  toJS:(val)=>

    try
      # ...
      super(val)
    catch e
      # ...
      console.log e

    if this.messages.length > 0
      return val
    #文字列じゃなかったら続行しない
    unless typeof val is "string"
      this._execError()
      return val

    hasSchema = val.match(/http:\/\/|https:\/\//)
    if not hasSchema
      if not this.addHttp
        #not schema
        this.messages.push new InValid(this.propName, "url")
      else
        val = location.protocol + "//" + val


    isVaild = true
    #isIP
    match = val.match(this.regex)

    match = val.match(this.VAILD_URL)

    isVaild = false unless match

    # console.log match, "u"
    # if typeof match is "array"
    #   for m in match
    #     unless m
    #       isVaild = false
    #       break
    this.messages.push new InValid(this.propName, "email") unless isVaild
      #invalid url
    this._execError()
    return val

module.exports = URLValidator