import smtp

proc sendMail(fromAddr: string; toAddrs, ccAddrs: seq[string];
              subject, message, login, password: string;
              server = "smtp.gmail.com"; port = 465; ssl = true) =
  var msg = createMessage(subject, message, toAddrs, ccAddrs)
  var s = connect(server, port, ssl, debug = true)
  s.auth(login, password)
  s.sendmail(fromAddr, toAddrs, $msg)

sendMail(fromAddr = "nimrod@gmail.com",
         toAddrs  = @["someone@example.com"],
         ccAddrs  = @[],
         subject  = "Hi from Nimrod",
         message  = "Nimrod says hi!\nAnd bye again!",
         login    = "foo@gmail.com",
         password = "XXXXXX")
