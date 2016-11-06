[
  'vim-enhanced',
  'git'
].each do |pkg|
  package pkg do
    action :install
  end
end
