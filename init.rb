# Redmine Redcarpet Formatter
# Copyright (C) 2012 Takashi Okamoto
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

require 'redmine'
require 'redmine/wiki_formatting/markdown/formatter'
require 'redmine/wiki_formatting/markdown/helper'


Redmine::Plugin.register :redmine_redcarpet_formatter do
  name 'Redcarpet Markdown Wiki formatter'
  author 'Mikoto Misaka'
  description 'Markdown wiki formatting by Redcarpet for Redmine'
  version '2.0.1'

  wiki_format_provider 'markdown', Redmine::WikiFormatting::Markdown::Formatter, Redmine::WikiFormatting::Markdown::Helper

end
