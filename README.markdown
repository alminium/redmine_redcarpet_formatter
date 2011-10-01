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

*  Redmine >= 0.9.4
*  Redcarpetr >= 2.0.0b5 - see https://github.com/tanoku/redcarpet


Installation
------------
1.  Install Redcarpet gem. Redcarpet version should be 2.0.0b5 or later.
<pre>
# gem install --version 2.0.0b5 redcarpet
</pre>
2.  Copy the plugin directory into the vendor/plugins directory
3.  Run rake at Redmine installed directory.
<pre>
# RAILS_ENV=production rake db:migrate_plugins
</pre>
4.  Start Redmine.
5.  Installed plugins are listed on 'Admin -> Information' screen.
6.  Config Wiki engine for 'markdown' on 'Admin -> Settings -> Text formatting' screen.


Credits
-------

*  Yuki Sonoda (http://github.com/yugui) did the real work by creating the redmine_rd_formatter
*  Larry Baltz (https://github.com/bitherder/) did develop redmine_markdown_formatter
*  william melody(https://github.com/alphabetum) develop redmine_restrucutedtext_formatter

Suggestions, Bugs, Refactoring?
-------------------------------

Fork away and create a Github Issue. Pull requests are welcome.
http://github.com/juno/redmine_markdown_extra_formatter/tree/master

