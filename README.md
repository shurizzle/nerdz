NERDZ
=====

blah blah blah

Nerdz class
-----------

*login:*
arguments: username:[String, Symbol], password:[String, Symbol]

*user:*
arguments: username:String

*nerdz:*
arguments: message:[String, Symbol], (to:[String, Symbol, Integer])
  post message in your profile if to arguments is obmited

*share:*
arguments: url:[String, Symbol], message:[String, Symbol], (to:[String, Symbol, Integer])
  same as nerdz, but with an url

*nerdzs:*
arguments: what:[String, Symbol], args:Hash
  what can be users, project and profile and args can have :from, :max, :user and :pid
  please see http://www.nerdz.eu/NERDZ+API: for documentation.

*logout*

_EXAMPLE_:
----------
  require 'nerdz'

  def hr; puts(?= \* 20); end

  browser = Nerdz.new
  browser.login('user', :password)
  p browser.user(:nessuno)
  hr
  browser.nerdz('you fuckin homo', :nessuno)
  browser.share('http://www.youtube.com/watch?v=3j4t185wl-0', '"nessuno" in the video')
  p browser.nerdzs(:projects, from: 20, max: 5)
  browser.logout
