define :install, :home => nil, :installRoot => nil, :pkgRepoUrl => nil, :pkgFilename => nil, :pkgChecksum => nil, :user => nil, :group => nil do

   remote_file "#{Chef::Config[:file_cache_path]}/#{params[:pkgFilename]}" do
         source "#{params[:pkgRepoUrl]}"
         checksum "#{params[:pkgChecksum]}"
         mode 0644
   end

   group "#{params[:group]}" do
      gid 2000
   end


   user "#{params[:user]}" do
     comment "Nenxus User"
     uid "2000"
     gid "#{params[:group]}"
     home "#{params[:home]}"
     shell "/bin/bash"
   end

   directory "#{params[:home]}" do
      owner "#{params[:user]}"
      group "#{params[:group]}"
      mode "0755"
      action :create
   end

   script "install" do
      interpreter "bash"
      user "#{params[:user]}"
      group "#{params[:group]}"
      code <<-EOH

         tar -C #{params[:home]} -zxf #{Chef::Config[:file_cache_path]}/#{params[:pkgFilename]}

      EOH
      not_if do
         File.exists?(params[:installRoot])
      end
   end

   script "setup" do
      interpreter "bash"
      user "root"
      group "root"
      code <<-EOH
         cp #{params[:installRoot]}/bin/jsw/#{params[:os]}-#{params[:kernel]}/nexus /etc/init.d/nexus
         chmod 755 /etc/init.d/nexus
         (cd /etc/rc3.d; ln -snf ../init.d/nexus S99nexus)
      EOH
      not_if do
         File.exists?("/etc/init.d/nexus")
      end
   end


end
