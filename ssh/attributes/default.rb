default[:ssh][:enable_password] = false
default[:ssh][:hostkeys] = %w{
    /etc/ssh/ssh_host_rsa_key
    /etc/ssh/ssh_host_dsa_key
}
default[:ssh][:matches] = {}
default[:ssh][:ports] = [22]
default[:ssh][:subsystems] = { 'sftp' => '/usr/lib/openssh/sftp-server' }
default[:ssh][:users] = []
default[:ssh][:group] = 'sshusers'
default[:ssh][:sftp] = {
    :dir => '/srv/sftp',
    :group => 'sftpusers',
    :users => [],
    :upload_dir => 'uploads',
}

sftp_group = node[:ssh][:sftp][:group]
default[:ssh][:allow_groups] = [
    node[:ssh][:group],
    sftp_group,
]

if node[:ssh][:sftp][:users]
    default[:ssh][:matches] = {
        "Group #{sftp_group}" => {
            'ChrootDirectory' => "#{node[:ssh][:sftp][:dir]}/%u",
            'ForceCommand' => 'internal-sftp',
            'PasswordAuthentication' => 'yes',
        }
    }
end

case node[:platform]
when 'redhat', 'centos', 'amazon'
    default[:ssh][:service] = 'sshd'
when 'ubuntu'
    default[:ssh][:service] = 'ssh'
    if node[:platform_version].to_f >= 12.04
        default[:ssh][:hostkeys] = %w{
            /etc/ssh/ssh_host_rsa_key
            /etc/ssh/ssh_host_dsa_key
            /etc/ssh/ssh_host_ecdsa_key
        }
    end
end
