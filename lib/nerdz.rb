#--
# Copyleft shura. [ shura1991@gmail.com ]
#
# This file is part of nerdz.
#
# nerdz is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# nerdz is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with nerdz. If not, see <http://www.gnu.org/licenses/>.
#++

require 'json'
require 'nerdz/http'
require 'nerdz/errors'
require 'nerdz/structs'

class Nerdz
  def initialize
    @http = HTTP.new
  end

  def request(*args)
    res = JSON.parse(@http.request(*args).body)
    error = res['error']
    error = ERRORS[error ? error.to_i : error]
    raise error if error
    res
  end

  def login(username, password)
    request(:login, {username: username, password: password})
    true
  end

  def logout
    request(:logout)
    true
  end

  def user(id_or_name)
    case id_or_name
    when Integer
      User.new(id_or_name, nil)
    when String, Symbol
      User.new(request(:get_id, {username: id_or_name})['id'], id_or_name.to_s)
    end
  end

  def nerdz(message, to = nil)
    opts = {message: message}
    opts[:to] = self.user(to).id if to
    request(:nerdz_it, opts)
    true
  end

  def share(url, message = "", to = nil)
    opts = {url: url, message: message}
    opts[:to] = self.user(to).id if to
    request(:share_it, opts)
    true
  end

  def nerdzs(what, args = {})
    opts = {what: what}
    opts[:limit] = args[:from] ? "#{args[:from]},#{args[:max]}" : args[:max].to_s if args[:max]
    opts[:id] = self.user(args[:user]).id if args[:user]
    opts[:pid] = args[:pid] if args[:pid]
    res = request(:nerdzs, opts)
    if res.values.first.is_a?(Hash)
      res.values.map {|nerdz|
        Post.new(nerdz)
      }
    else
      Post.new(res)
    end
  end
end
