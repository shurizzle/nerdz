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

require 'cgi'
require 'net/http'
require 'nerdz/version'

class URI::Generic
  def request
    x = self.dup
    x.component.take_while {|y| y != :path }.each {|y| x.send("#{y}=".to_sym, nil) }
    x.to_s
  end
end

class Hash
  def to_param
    self.to_a.map {|kv|
      kv.map {|v| CGI.escape(v.to_s) }.join(?=)
    }.join(?&)
  end

  def self.from_param(par)
    Hash[par.split('&').map {|x| x.split('=', 2).map {|y| CGI.unescape(y) } }]
  rescue
    {}
  end
end

class String
  def merge_param(par)
    uri = URI.parse(self)
    uri.query = Hash.from_param(uri.query).merge(par).to_param
    uri.to_s
  end

  def merge_param!(par)
    self.replace(self.merge_param(par))
  end
end

module Net
  class HTTPResponse
    def [](key)
      @header[key.to_s.downcase].join(', ')
    rescue
      nil
    end

    def keys
      @header.keys
    end

    def values
      @header.values
    end
  end

  class HTTP
    alias __old_post__ post
    def post(path, params = {}, data = {}, initheader = nil, dest = nil, &block)
      path.merge_param!(params)
      data = data.to_param if data.is_a?(Hash)

      __old_post__(path, data, initheader, dest, &block)
    end
  end

  class HTTPGenericRequest
    def initialize(m, reqbody, resbody, path, initheader = nil)
      @method = m
      @request_has_body = reqbody
      @response_has_body = resbody
      raise ArgumentError, "no HTTP request path given" unless path
      raise ArgumentError, "HTTP request path is empty" if path.empty?
      @path = path
      initialize_http_header initheader
      self['Accept'] ||= '*/*'
      self['User-Agent'] ||= "Ruby Nerdz #{Nerdz::VERSION}"
      @body = nil
      @body_stream = nil
    end
  end
end
