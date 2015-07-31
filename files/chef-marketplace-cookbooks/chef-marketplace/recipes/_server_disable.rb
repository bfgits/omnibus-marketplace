# Add chef-server-ctl marketplace-setup shim for backwards compatability
directory '/opt/opscode/embedded/service/omnibus-ctl' do
  owner 'root'
  group 'root'
  recursive true
  action :create
end

file '/opt/opscode/embedded/service/omnibus-ctl/marketplace_setup.rb' do
  action :delete
end

motd '50-chef-marketplace-appliance' do
  action :delete
end

template '/etc/cron.d/reporting-partition-cleanup' do
  action :delete
end

file "etc/chef/ohai/hints/#{node['chef-marketplace']['platform']}.json" do
  action :delete
end

user node['chef-marketplace']['user'] do
  action :delete
end

package 'cloud-init' do
  action :uninstall
end

template '/etc/cloud/cloud.cfg' do
  action :delete
end
