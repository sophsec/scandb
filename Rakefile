# -*- ruby -*-

require 'rubygems'
require 'hoe'
require './lib/scandb/version.rb'

Hoe.new('scandb', ScanDB::VERSION) do |p|
  p.rubyforge_name = 'scandb'
  p.developer('Postmodern Modulus III', 'postmodern.mod3@gmail.com')
  p.remote_rdoc_dir = ''
  p.extra_deps = [
    ['do_sqlite3', '>=0.9.3'],
    ['dm-core', '>=0.9.3'],
    ['dm-types', '>=0.9.3'],
    ['dm-serializer','>=0.9.3'],
    'libxml-ruby'
  ]
end

# vim: syntax=Ruby
