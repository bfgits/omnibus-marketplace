name "chef-marketplace"
maintainer "Chef Software, Inc. <partnereng@chef.io>"
homepage "http://www.chef.io"
license "Apache-2.0"
license_file "LICENSE"

install_dir "/opt/chef-marketplace"
build_version Omnibus::BuildVersion.semver
build_iteration 1

override :ruby, version: "2.2.4"
override :chef, version: "master"
override :berkshelf, version: "v4.2.3"

dependency "preparation"
dependency "postgresql92" # only the client
dependency "sequel-gem"
dependency "pg-gem"
dependency "server-plugin-cookbooks"
dependency "reckoner"
dependency "biscotti"
dependency "chef"
dependency "chef-marketplace-ctl"
dependency "chef-marketplace-gem"
dependency "chef-marketplace-cookbooks"
dependency "remove-nodejs"
dependency "version-manifest"

exclude '\.git*'
exclude 'bundler\/git'

package :rpm do
  signing_passphrase ENV["OMNIBUS_RPM_SIGNING_PASSPHRASE"]
end
