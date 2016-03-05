#!/usr/bin/env ruby
# coding: utf-8

require 'net/pop'
require 'net/imap'

$server1 = '******'
$name1 = '******'
$pass1 = '******'

$server2 = 'imap.gmail.com'
$name2 = '******@gmail.com'
$pass2 = '******'

########################################
# function
########################################

def get_n_mail (server, name, pass, connect)
  case connect
  when "pop3"
    pop = Net::POP3.new(server, 110)
    pop.start(name, pass)
    n = pop.n_mails
    pop.finish
    return n
  when "imap"
    imap = Net::IMAP.new(server, 993, true)
    imap.login(name, pass)
    imap.select('INBOX')
    search_criterias = ['UNSEEN']
    n = imap.search(search_criterias).length
    imap.logout
    imap.disconnect
    return n
  else
    # do nothing
  end
end


########################################
# get numbers of mail
########################################

n1 = get_n_mail($server1, $name1, $pass1, "pop3")
n2 = get_n_mail($server2, $name2, $pass2, "imap")


########################################
# Result
########################################

printf "mail1:%d/mail2:%d", n1, n2

