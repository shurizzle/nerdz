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

class String
  def esc_split(s)
    return if s.size != 1
    e = Regexp.escape(s.to_s)

    self.scan(/(?:((?:\\#{e}|[^#{e}])*)(?:$|#{e}))/).flatten.tap {|res|
      break res[0..-2] if !self.end_with?(s.to_s)
    }
  end
end
