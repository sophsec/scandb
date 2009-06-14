# -*- ruby -*-

require 'rubygems'
require 'hoe'
require 'hoe/signing'
require './lib/scandb/version.rb'

Hoe.spec('scandb') do |p|
  self.rubyforge_name = 'scandb'
  self.developer('Postmodern', 'postmodern.mod3@gmail.com')
  self.remote_rdoc_dir = ''
  self.extra_deps = [
    ['do_sqlite3', '>=0.9.13'],
    ['dm-core', '>=0.10.0'],
    ['dm-types', '>=0.10.0'],
    ['dm-serializer','>=0.10.0'],
    'libxml-ruby'
  ]
end

# vim: syntax=Ruby
