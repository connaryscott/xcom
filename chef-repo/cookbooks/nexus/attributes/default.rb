
default[:nexus][:downloads][:url] = "http://nexus.sonatype.org/downloads"

default[:nexus][:package][:name] = "nexus-oss-webapp"
default[:nexus][:package][:version] = "1.9.2"
default[:nexus][:installRoot] = "/opt/nexus/#{node[:nexus][:package][:name]}-#{node[:nexus][:package][:version]}"
default[:nexus][:work] = "#{node[:nexus][:installRoot]}/../sonatype-work"

#256 bit sha checksum (see shasum command)
default[:nexus][:package][:checksum] = "30871fbc042deeaff9e858940d1a3e5d3e076b185aa91351f47c3bcd3c719931"
default[:nexus][:package][:dist] = "tar.gz"
default[:nexus][:package][:filename] = "#{node[:nexus][:package][:name]}-#{node[:nexus][:package][:version]}-bundle.#{node[:nexus][:package][:dist]}"
default[:nexus][:package][:url] = "#{node[:nexus][:downloads][:url]}/#{node[:nexus][:package][:filename]}"

#
# obtain from:   https://github.com/downloads/vbehar/nexus-rundeck-plugin/nexus-rundeck-plugin-1.2-bundle.zip
#
default[:nexus][:plugins][:rundeck][:version] = "1.2"
