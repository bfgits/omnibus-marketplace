include_recipe 'chef-marketplace::config'

# Setup the MOTD first so that the user doesn't see old data if the shell in
# before the chef-client has finished converging
motd '50-chef-marketplace-appliance' do
  source 'motd.erb'
  cookbook 'chef-marketplace'
  variables motd_variables
  action motd_action
end

include_recipe 'chef-marketplace::_register_plugin'

# 'server', 'analytics', 'aio', 'compliance'
role = node['chef-marketplace']['role']

# Base recipes for role
include_recipe "chef-marketplace::_#{role}_enable"

# Setup billing daemon
include_recipe 'chef-marketplace::_reckoner'

# Setup omnibus-ctl commands
include_recipe 'chef-marketplace::_omnibus_commands'
