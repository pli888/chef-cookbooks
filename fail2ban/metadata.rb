name 'fail2ban'
maintainer 'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license 'Apache 2.0'
description 'Installs and configures fail2ban'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '2.3.1'

recipe 'default', 'Installs and configures fail2ban'

%w(amazon centos debian fedora oracle redhat scientific ubuntu suse ).each do |os|
  supports os
end

source_url 'https://github.com/chef-cookbooks/fail2ban' if respond_to?(:source_url)
issues_url 'https://github.com/chef-cookbooks/fail2ban/issues' if respond_to?(:issues_url)
