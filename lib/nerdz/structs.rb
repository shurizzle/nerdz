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

class Nerdz
  class User
    attr_reader :id, :name
    def initialize(id, name)
      @id = id.to_i
      @name = name
    end
  end

  class Post
    attr_reader :from, :to, :pid, :message, :time

    def initialize(h)
      @to = User.new(h['to'], h['to_user'])
      @from = User.new(h['from'], h['from_user'])
      @pid = h['pid'].to_i rescue nil
      @message = h['message']
      @time = Time.mktime(*(h['date'].split(?/).reverse + (h['time'] || '').split(?:))) if h['date']
    end
  end
end
