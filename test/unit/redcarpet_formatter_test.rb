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

require File.expand_path('../../test_helper', __FILE__)
require 'digest/md5'

class Redmine::WikiFormatting::RedcarpetFormatterTest < ActionView::TestCase

  def setup
    @formatter = RedmineRedcarpetFormatter::WikiFormatter
  end

  STR_WITHOUT_PRE = [
  # 0
"# Title

Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Maecenas sed libero.",
  # 1
"## Heading 2

Maecenas sed elit sit amet mi accumsan vestibulum non nec velit. Proin porta tincidunt lorem, consequat rhoncus dolor fermentum in.

Cras ipsum felis, ultrices at porttitor vel, faucibus eu nunc.",
  # 2
"## Heading 2

Morbi facilisis accumsan orci non pharetra.

### Heading 3

Nulla nunc nisi, egestas in ornare vel, posuere ac libero.",
  # 3
"### Heading 3

Praesent eget turpis nibh, a lacinia nulla.",
  # 4
"## Heading 2

Ut rhoncus elementum adipiscing."]

  TEXT_WITHOUT_PRE = STR_WITHOUT_PRE.join("\n\n").freeze


  STR_WITHOUT_PRE_ALTER = STR_WITHOUT_PRE.map{|x| 
    x.split("\n").map do |line|
      if line =~ /^([#]{1,2}) *([^#]+)$/
        $2 + "\n" + ($1.length == 1 ? '===' : '---') + "\n"
      else
        line
      end
    end.join("\n")
  }

  TEXT_WITHOUT_PRE_ALTER = STR_WITHOUT_PRE_ALTER.join("\n\n").freeze

  
  def test_get_section_should_return_the_requested_section_and_its_hash
    [[STR_WITHOUT_PRE, TEXT_WITHOUT_PRE],[STR_WITHOUT_PRE_ALTER, TEXT_WITHOUT_PRE_ALTER]].each do |items|
      str, text = items
      assert_section_with_hash str[1], text, 2
      assert_section_with_hash str[2..3].join("\n\n"), text, 3
      assert_section_with_hash str[3], text, 5
      assert_section_with_hash str[4], text, 6

      assert_section_with_hash '', text, 0
      assert_section_with_hash '', text, 10
    end
  end

  def test_update_section_should_update_the_requested_section
    replacement = "New text"

    assert_equal [STR_WITHOUT_PRE[0], replacement, STR_WITHOUT_PRE[2..4]].flatten.join("\n\n"), @formatter.new(TEXT_WITHOUT_PRE).update_section(2, replacement)
    assert_equal [STR_WITHOUT_PRE[0..1], replacement, STR_WITHOUT_PRE[4]].flatten.join("\n\n"), @formatter.new(TEXT_WITHOUT_PRE).update_section(3, replacement)
    assert_equal [STR_WITHOUT_PRE[0..2], replacement, STR_WITHOUT_PRE[4]].flatten.join("\n\n"), @formatter.new(TEXT_WITHOUT_PRE).update_section(5, replacement)
    assert_equal [STR_WITHOUT_PRE[0..3], replacement].flatten.join("\n\n"), @formatter.new(TEXT_WITHOUT_PRE).update_section(6, replacement)

    assert_equal TEXT_WITHOUT_PRE, @formatter.new(TEXT_WITHOUT_PRE).update_section(0, replacement)
    assert_equal TEXT_WITHOUT_PRE, @formatter.new(TEXT_WITHOUT_PRE).update_section(10, replacement)
  end

  def test_update_section_with_hash_should_update_the_requested_section
    replacement = "New text"

    assert_equal [STR_WITHOUT_PRE[0], replacement, STR_WITHOUT_PRE[2..4]].flatten.join("\n\n"),
      @formatter.new(TEXT_WITHOUT_PRE).update_section(2, replacement, Digest::MD5.hexdigest(STR_WITHOUT_PRE[1]))
  end

  def test_update_section_with_wrong_hash_should_raise_an_error
    assert_raise Redmine::WikiFormatting::StaleSectionError do
      @formatter.new(TEXT_WITHOUT_PRE).update_section(2, "New text", Digest::MD5.hexdigest("Old text"))
    end
  end

  STR_WITH_PRE = [
    # 0
    "# Title

Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Maecenas sed libero.",
# 1
"## Heading 2

~~~ ruby
  def foo
  end
~~~

Morbi facilisis accumsan orci non pharetra.


```
Pre Content:

## Inside pre

<tag> inside pre block

Morbi facilisis accumsan orci non pharetra.
```",
# 2
"### Heading 3

Nulla nunc nisi, egestas in ornare vel, posuere ac libero."]

def test_get_section_should_ignore_pre_content
  text = STR_WITH_PRE.join("\n\n")

  assert_section_with_hash STR_WITH_PRE[1..2].join("\n\n"), text, 2
  assert_section_with_hash STR_WITH_PRE[2], text, 3
end

def test_update_section_should_not_escape_pre_content_outside_section
  text = STR_WITH_PRE.join("\n\n")
  replacement = "New text"

  assert_equal [STR_WITH_PRE[0..1], "New text"].flatten.join("\n\n"),
    @formatter.new(text).update_section(3, replacement)
end

private

def assert_section_with_hash(expected, text, index)
  result = @formatter.new(text).get_section(index)

  assert_kind_of Array, result
  assert_equal 2, result.size
  assert_equal expected, result.first, "section content did not match"
  assert_equal Digest::MD5.hexdigest(expected), result.last, "section hash did not match"
end
end
