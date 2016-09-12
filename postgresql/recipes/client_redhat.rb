version = node[:postgresql][:version]
repo_version = node[:postgresql][:repo_version]

puts "PostgreSQL version: " + version
puts "PostgreSQL repo version: "  + repo_version

# if version == node[:postgresql][:repo_version]
#   package 'postgresql-devel'
# else
#    yum_repository "pgdg-#{version}" do
#        baseurl "http://yum.postgresql.org/#{version}/redhat/rhel-$releasever-$basearch"
#        description "PostgreSQL #{version}"
#        gpgkey 'http://yum.postgresql.org/RPM-GPG-KEY-PGDG'
#    end
#    package "postgresql#{version.split('.').join}-devel"
# end

yum_repository "pgdg-#{version}" do
    baseurl "http://yum.postgresql.org/#{version}/redhat/rhel-$releasever-$basearch"
    description "PostgreSQL #{version}"
    gpgkey 'http://yum.postgresql.org/RPM-GPG-KEY-PGDG'
end

package "postgresql#{version.split('.').join}-devel"
