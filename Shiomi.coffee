DEFAULT_MSG = require "shiomi/messages/default"


Shiomi =
  msgmap: DEFAULT_MSG

  updateMsg: (map)->
    Shiomi.msgmap = map
    return

  getMsg: (type)->
    if Shiomi.msgmap.hasOwnProperty type
      return Shiomi.msgmap[type]
    return Shiomi.msgmap.default

module.exports = Shiomi