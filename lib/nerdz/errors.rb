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

def exception
  Class.new(Exception)
end

class Nerdz
  NotLoggedIn = exception
  UserNotFound = exception
  GETQueryNotFound = exception
  POSTQueryNotFound = exception
  UndefinedError = exception
  LoginError = exception
  InsertError = exception
  ShareError = exception
  InvalidUrl = exception
  InvalidAction = exception
  NotOnline = exception

  ERRORS = Class.new {
    def initialize
      @errors = [nil, NotLoggedIn, UserNotFound, GETQueryNotFound,
        POSTQueryNotFound, UndefinedError, LoginError, InsertError,
        ShareError, InvalidUrl, InvalidAction, NotOnline].freeze
    end

    def [](x)
      x = x.to_s.to_i unless x.is_a?(Integer)
      @errors[x.to_i]
    end
  }.new
end
