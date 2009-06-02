# -*- ruby -*-

require 'rubygems'
require 'hoe'
require './lib/scandb/version.rb'

Hoe.new('scandb', ScanDB::VERSION) do |p|
  p.rubyforge_name = 'scandb'
  p.developer('Postmodern', 'postmodern.mod3@gmail.com')
  p.remote_rdoc_dir = ''
  p.extra_deps = [
    ['do_sqlite3', '>=0.9.13'],
    ['dm-core', '>=0.10.0'],
    ['dm-types', '>=0.10.0'],
    ['dm-serializer','>=0.10.0'],
    'libxml-ruby'
  ]
end

# vim: syntax=Ruby
