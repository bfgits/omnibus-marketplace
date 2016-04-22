bash "chef-marketplace-ctl reconfigure" do
  code "chef-marketplace-ctl reconfigure"
  action :nothing
end

ruby_block "remove-marketplace-from-cache" do
  block do
    package = Dir["#{Chef::Config[:file_cache_path]}/*"].find { |f| f =~ /chef-marketplace/ }
    FileUtils.rm(package) if package && File.exist?(package)
  end

  action :nothing
end

bash "chef-marketplace-ctl stop" do
  code "chef-marketplace-ctl stop"
end

chef_ingredient "chef-marketplace" do
  action :upgrade
  notifies :run, "bash[chef-marketplace-ctl reconfigure]"
  notifies :run, "ruby_block[remove-marketplace-from-cache]", :immediately
  notifies :run, "bash[yum-clean-all]", :immediately
  notifies :run, "bash[apt-get-clean]", :immediately
end

bash "chef-marketplace-ctl start" do
  code "chef-marketplace-ctl start"
end
