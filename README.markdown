Redmine Redcarpet Markdown formatter
================================

This is a redmine plugin for supporting Markdown as a wiki format. This plugin use Redcarpet which is GitHub's markdown wiki formatter.
Redcarpet is extreme fast and compatible GitHub's Wiki. They are advantage from Redmine Markdown Formatter and Redmine Markdown Extra Formatter.
This code is originally Redmine Markdown Formatter and Redmine reStructuredtext Formatter. I appreciate these guys.

What is redmine?
----------------

Redmine is a flexible project management web application.
See [the official site](http://www.redmine.org/) for more details.


What is Markdown?
-----------------------

(from http://daringfireball.net/projects/markdown/)
Markdown is a text-to-HTML conversion tool for web writers. Markdown allows
you to write using an easy-to-read, easy-to-write plain text format, then
convert it to structurally valid XHTML (or HTML).

Prerequisites
-------------

*  Redmine 1.x, Remine 2.x
*  Redcarpetr >= 2.0.0b5 - see https://github.com/tanoku/redcarpet


Installation
------------

### Redmine 1.x
1.  Install Redcarpet gem. Redcarpet version should be 2.0.0b5 or later.
 
    $ sudo gem install --version 2.0.0b5 redcarpet

2. Clone and checkout plugin

``` 
    $ git clone https://github.com/alminium/redmine_redcarpet_formatter.git
    $ git tags
    ...
    v1.1.1    // for Redmine 1.x
    v2.0.0    // for Redmine 2.x
```

v1.x.x series is for Redmine 1.x. v2.x.x series is for Redmine 2.x. Please
Checkout your version. This example is for Redmine 2.x:
 
    $ git checkout v2.0.0

3.  Copy the redmine_redcarpet_formatter directory into

 * vendor/plugins directory (for Redmine 1.x)
 * plugins/ directory (for Redmine 2.x)

4.  Run rake at Redmine installed directory.

```
    [for Redmine 1.x]
    # RAILS_ENV=production rake db:migrate_plugins
    [for Redmine 2.x]
    # RAILS_ENV=production rake redmine:plugins:migrate
```

5.  Restart Redmine.
6.  Installed plugins are listed on 'Admin -> Information' screen.
7.  Config Wiki engine for 'markdown' on 'Admin -> Settings -> Text formatting' screen.

Caution
-------
source: link is broken with original redcarpet gem.
Our fork resolved this problem. Install the fork:

<pre>
# git clone https://github.com/alminium/redcarpet.git
# cd redcarpet
# rake install
</pre>

Credits
-------
*  Hiroyuki MORITA (Thanks for multi section edit)
*  mikoto20000 (http://github.com/mikoto20000) develop redmine_redcarpet_formatter
*  Yuki Sonoda (http://github.com/yugui) did the real work by creating the redmine_rd_formatter
*  Larry Baltz (https://github.com/bitherder/) did develop redmine_markdown_formatter
*  william melody(https://github.com/alphabetum) develop redmine_restrucutedtext_formatter

Suggestions, Bugs, Refactoring?
-------------------------------

Fork away and create a Github Issue. Pull requests are welcome.
https://github.com/alminium/redmine_redcarpet_formatter

