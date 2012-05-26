# Redmine Redcarpet formatter

require 'redmine'
require 'redmine/wiki_formatting/redcarpet/formatter'
require 'redmine/wiki_formatting/redcarpet/helper'


Redmine::Plugin.register :redmine_redcarpet_formatter do
  name 'Redcarpet Markdown Wiki formatter'
  author 'Mikoto Misaka'
  description 'Markdown wiki formatting by Redcarpet for Redmine'
  version '1.1.1'

  wiki_format_provider 'markdown', Redmine::WikiFormatting::Redcarpet::Formatter, Redmine::WikiFormatting::Redcarpet::Helper

end
