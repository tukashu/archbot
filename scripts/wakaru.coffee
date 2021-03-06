module.exports = (robot) ->
  messages = [null, null]
  robot.brain.autoSave = true

  robot.hear //, (msg) ->
    if match = msg.message.text.match(/^([a-z0-9]+)?\s*(わかる|それな)\s*([a-z0-9]+)?$/)

      user =
        if match[1]
          robot.brain.userForName match[1]
        else if match[3]
          robot.brain.userForName match[3]
        else if messages[1]
          robot.brain.userForId messages[1].user.id

      if user
        switch match[2]
          when "わかる"
            user.wakaru = 0 unless user.wakaru
            user.wakaru += 1
            msg.send "#{user.name} #{user.wakaru} わかる"
          when "それな"
            user.sorena = 0 unless user.sorena
            user.sorena += 1
            msg.send "#{user.name} #{user.sorena} それな"
          else
            msg.send "unknown unit"
      else
        msg.send "unknown user"

    else
      messages.shift()
      messages.push msg.message
