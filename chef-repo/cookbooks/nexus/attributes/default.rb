
default[:nexus][:home] = "/opt/nexus"
default[:nexus][:downloads][:url] = "http://nexus.sonatype.org/downloads"

default[:nexus][:package][:name] = "nexus-oss-webapp"
default[:nexus][:package][:version] = "1.9.2"
default[:nexus][:installRoot] = "#{node[:nexus][:home]}/#{node[:nexus][:package][:name]}-#{node[:nexus][:package][:version]}"
default[:nexus][:work] = "#{node[:nexus][:home]}/sonatype-work"

#256 bit sha checksum (see shasum command)
default[:nexus][:package][:checksum] = "30871fbc042deeaff9e858940d1a3e5d3e076b185aa91351f47c3bcd3c719931"
default[:nexus][:package][:dist] = "tar.gz"
default[:nexus][:package][:filename] = "#{node[:nexus][:package][:name]}-#{node[:nexus][:package][:version]}-bundle.#{node[:nexus][:package][:dist]}"
default[:nexus][:package][:url] = "#{node[:nexus][:downloads][:url]}/#{node[:nexus][:package][:filename]}"

#
# obtained from:   https://github.com/downloads/vbehar/nexus-rundeck-plugin/nexus-rundeck-plugin-1.2-bundle.zip
# NOTE:  this plugin as been reassembled due to runtime limitations of nexus, see:  http://kb.dtosolutions.com/wiki/Nexus-rundeck-plugin_options_service
#
default[:nexus][:plugins][:rundeck][:version] = "1.2"

#
# horrific default, let's get some real nexus users going!
#
default[:nexus][:user] = "root"
default[:nexus][:group] = "root"
