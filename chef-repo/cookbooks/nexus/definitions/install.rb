define :install, :installRoot => nil, :pkgRepoUrl => nil, :pkgFilename => nil, :pkgChecksum => nil, :user => nil, :group => nil do

         remote_file "#{Chef::Config[:file_cache_path]}/#{params[:pkgFilename]}" do
            source "#{params[:pkgRepoUrl]}"
            checksum "#{params[:pkgChecksum]}"
            mode 0644
         end

   script "install" do
      interpreter "bash"
      user "#{params[:user]}"
      group "#{params[:group]}"
      code <<-EOH

         mkdir -p #{params[:installRoot]} &&
         tar -C #{params[:installRoot]}/.. -zxf #{Chef::Config[:file_cache_path]}/#{params[:pkgFilename]}

      EOH
      not_if do
         File.exists?(params[:installRoot])
      end
   end

end

