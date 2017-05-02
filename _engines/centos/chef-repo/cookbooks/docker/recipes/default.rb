cookbook_file '/etc/yum.repos.d/docker-ce.repo' do
  source 'etc/yum.repos.d/docker-ce.repo'
  owner 'root'
  group 'root'
  mode 0644
end

package 'docker-ce' do
  action :install
end

service 'docker' do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end

user 'docker' do
  home '/home/docker'
  shell '/bin/bash'
  password nil
  group 'docker'
  manage_home true
  action :create
end

bash "ensure /usr/local/bin/docker-compose is installed" do
  ver = node['docker_compose']['version'] || '1.12.0'
  code <<-EOH
    curl -L https://github.com/docker/compose/releases/download/#{ver}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
    chmod 755 /usr/local/bin/docker-compose
  EOH
  not_if "test -f /usr/local/bin/docker-compose"
end
