#
# Cookbook Name:: nexus
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

packageUrl = node[:nexus][:package][:url]
packageFilename = node[:nexus][:package][:filename]
packageChecksum = node[:nexus][:package][:checksum]

homeDir =  node[:nexus][:home]
installRoot =  node[:nexus][:installRoot]
workDir =  node[:nexus][:work]

rundeckPluginVersion = node[:nexus][:plugins][:rundeck][:version]

nexusUser = node[:nexus][:user]
nexusGroup = node[:nexus][:group]

install "nexus" do
  home homeDir
  installRoot installRoot 
  pkgRepoUrl packageUrl
  pkgFilename packageFilename
  pkgChecksum packageChecksum
  user nexusUser
  group nexusGroup
end


directory "#{workDir}/nexus/plugin-repository" do
  owner nexusUser
  group nexusGroup
  mode "0755"
  action :create
end

cookbook_file "#{workDir}/nexus/plugin-repository/nexus-rundeck-plugin-#{rundeckPluginVersion}-bundle.zip" do 
  source "sonatype-work/nexus/plugin-repository/nexus-rundeck-plugin-#{rundeckPluginVersion}-bundle.zip"
  mode 0644
  owner nexusUser
  group nexusGroup
  not_if do 
     File.exists?("#{workDir}/nexus/plugin-repository/nexus-rundeck-plugin-#{rundeckPluginVersion}")
  end
end


#
# NOTE:  this plugin has been reassembled, refer to:  http://kb.dtosolutions.com/wiki/Nexus-rundeck-plugin_options_service
#
script "installRundeckPlugin" do
      interpreter "bash"
      user nexusUser
      group nexusGroup
      code <<-EOH
         cd #{workDir}/nexus/plugin-repository &&
         unzip nexus-rundeck-plugin-#{rundeckPluginVersion}-bundle.zip &&
         rm nexus-rundeck-plugin-#{rundeckPluginVersion}-bundle.zip 
      EOH
      not_if do
         File.exists?("#{workDir}/nexus/plugin-repository/nexus-rundeck-plugin-#{rundeckPluginVersion}")
      end
end

