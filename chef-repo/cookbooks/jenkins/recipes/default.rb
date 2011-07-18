#
# Cookbook Name:: jenkins
# Recipe:: default
#

# https://wiki.jenkins-ci.org/display/JENKINS/Installing+Jenkins+on+Ubuntu
# This is super-simple, compared to the other Chef cookbook I found
# for Jenkins (https://github.com/fnichol/chef-jenkins).
#
# This doesn't include Chef libraries for adding Jenkin's jobs via
# the command line, but it does get Jenkins up and running.
#
# I'd rather build up a Chef cookbook than strip it down, so here's
# a good starting point.

rundeckPluginVersion = node[:jenkins][:plugins][:rundeck][:version]
rundeckUser = node[:jenkins][:plugins][:rundeck][:user]
rundeckPassword = node[:jenkins][:plugins][:rundeck][:password]
rundeckUrl = node[:jenkins][:plugins][:rundeck][:url]


include_recipe "apt"
include_recipe "java"

apt_repository "jenkins" do
  uri "http://pkg.jenkins-ci.org/debian"
  key "http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key"
  components ["binary/"]
  action :add
end

package "jenkins"

service "jenkins" do
  supports [:stop, :start, :restart]
  action [:start, :enable]
end


directory "/var/lib/jenkins/plugins" do
  owner "jenkins"
  group "nogroup"
  mode "0755"
  action :create
end

cookbook_file "/var/lib/jenkins/plugins/rundeck.hpi" do
  source "var/lib/jenkins/plugins/rundeck-#{rundeckPluginVersion}.hpi"
  mode 0644
  owner "jenkins"
  group "nogroup"
  notifies :restart, resources(:service => "jenkins")
end

template "/var/lib/jenkins/org.jenkinsci.plugins.rundeck.RundeckNotifier.xml" do
  source "var/lib/jenkins/org.jenkinsci.plugins.rundeck.RundeckNotifier.xml.erb"
  mode 0644
  owner "jenkins"
  group "nogroup"
  variables({
     :url => rundeckUrl,
     :login => rundeckUser,
     :password => rundeckPassword
  })
  notifies :restart, resources(:service => "jenkins")
end
