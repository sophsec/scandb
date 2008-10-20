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

require 'scandb/model'
require 'scandb/host_name'
require 'scandb/os_class_guess'
require 'scandb/os_match_guess'
require 'scandb/scanned_port'

module ScanDB
  class Host

    include Model

    # The IP address of the Host
    property :ip, String

    # The host-names of the host
    has n, :names, :class_name => 'HostName'

    # The OS Class guesses of the host
    has n, :os_class_guesses, :class_name => 'OSClassGuess'

    # The OS Match guesses of the host
    has n, :os_match_guesses, :class_name => 'OSMatchGuess'

    # The scanned ports of the host
    has n, :scanned_ports

    #
    # Returns the primary host name.
    #
    def host_name
      names.first
    end

    #
    # Returns the best OS Class guess.
    #
    def best_class_guess
      os_class_guesses.first
    end

    #
    # Returns the best OS Match guess.
    #
    def best_match_guess
      os_match_guesses.first
    end

    #
    # Returns all the open ports on the host.
    #
    def open_ports
      scanned_ports.all(:status => :open)
    end

    #
    # Returns all the filtered ports on the host.
    #
    def filtered_ports
      scanned_ports.all(:status => :filtered)
    end

    #
    # Returns all the closed ports on the host.
    #
    def closed_ports
      scanned_ports.all(:status => :closed)
    end

    alias ports open_ports

    #
    # Returns the ports numbers of all open ports on the host.
    #
    def port_numbers
      open_ports.map { |port| port.number }
    end

    #
    # Returns the services of all open ports on the host.
    #
    def services
      ports.service
    end

    #
    # Returns the IP address of the host in String form.
    #
    def to_s
      ip
    end

  end
end
