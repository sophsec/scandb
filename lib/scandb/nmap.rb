#
#--
# ScanDB - A library for importing and analyzing information generated by
# various network scanning utilities.
#
# Copyright (c) 2008 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#++
#

require 'scandb/database'
require 'scandb/host'

require 'libxml'

module ScanDB
  module Nmap
    include LibXML

    #
    # Imports scan information from a Nmap XML scan file, specified by
    # the _path_. Returns an Array of Host objects.
    #
    #   Nmap.import_xml('path/to/scan.xml')
    #   # => [...]
    #
    def Nmap.import_xml(path)
      doc = XML::Document.file(path)
      hosts = []

      doc.find("/nmaprun/host[status[@state='up']]").each do |host|
        ip = host.find_first("address[@addr and @addrtype='ipv4']")['addr']
        new_host = Host.first_or_create(:ip => ip)

        host.find('hostnames/hostname').each do |hostname|
          new_host.names << HostName.first_or_create(
            :name => hostname['name']
          )
        end

        host.find('os/osclass').each do |osclass|
          new_os_class = OSClass.first_or_create(
            :type => osclass['type'],
            :vendor => osclass['vendor'],
            :family => osclass['osfamily'],
            :version => osclass['osgen']
          )

          new_host.os_class_guesses.first_or_create(
            :accuracy => osclass['accuracy'].to_i,
            :os_class_id => new_os_class.id,
            :host_id => new_host.id
          )
        end

        host.find('os/osmatch').each do |osmatch|
          new_os_match = OSMatch.first_or_create(
            :name => osmatch['name']
          )

          new_host.os_match_guesses.first_or_create(
            :accuracy => osmatch['accuracy'].to_i,
            :os_match_id => new_os_match.id,
            :host_id => new_host.id
          )
        end

        host.find('ports/port').each do |port|
          new_port = Port.first_or_create(
            :number => port['portid'].to_i,
            :protocol => port['protocol'].to_sym
          )

          new_service = Service.first_or_create(
            :name => port.find_first('service[@name]')['name']
          )

          new_host.scanned_ports.first_or_create(
            :status => port.find_first('state[@state]')['state'].to_sym,
            :service_id => new_service.id,
            :port_id => new_port.id,
            :host_id => new_host.id
          )
        end

        new_host.save

        hosts << new_host
      end

      return hosts
    end
  end
end
