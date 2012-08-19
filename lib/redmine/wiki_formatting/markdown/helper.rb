# -*- coding: utf-8 -*-
#
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

module Redmine
  module WikiFormatting
    
    module Markdown
      module Helper
        unloadable

        def wikitoolbar_for(field_id)
          heads_for_wiki_formatter
          url = "#{::Redmine::Utils.relative_url_root}/plugin_assets/redmine_redcarpet_formatter/help/wiki_syntax.html"      
          help_link = l(:setting_text_formatting) + ': ' +
            link_to(l(:label_help), url,
                    :onclick => "window.open(\"#{url}\", \"\", \"resizable=yes, location=no, width=480, height=640, menubar=no, status=no, scrollbars=yes\"); return false;")
          javascript_tag(<<-EOD);
      var toolbar = new jsToolBar(document.getElementById('#{field_id}'));
      toolbar.setHelpLink('#{help_link}');
      toolbar.draw();
      EOD
        end


        def initial_page_content(page)
          "#{page.pretty_title}\n#{'='*page.pretty_title.length}"
        end


        def heads_for_wiki_formatter
          unless @heads_for_wiki_formatter_included
            content_for :header_tags do
              javascript_include_tag('jstoolbar/jstoolbar') +
                javascript_include_tag('jstoolbar/redcarpet', :plugin => 'redmine_redcarpet_formatter') +
                javascript_include_tag("jstoolbar/lang/jstoolbar-#{current_language.to_s.downcase}") +
                stylesheet_link_tag('jstoolbar') +
                stylesheet_link_tag('html4css1', :plugin => 'redmine_redcarpet_formatter') +
                stylesheet_link_tag('redcarpet', :plugin => 'redmine_redcarpet_formatter')
            end
            @heads_for_wiki_formatter_included = true
          end
        end
      end
    end
  end
end
