cookbook_file '/etc/yum.repos.d/docker.repo' do
  source 'etc/yum.repos.d/docker.repo'
  owner 'root'
  group 'root'
  mode 0644
end

package 'docker-engine' do
  action :install
  options "--enablerepo=dockerrepo"
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
