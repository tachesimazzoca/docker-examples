require 'spec_helper'

describe package('docker-engine'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe service('docker'), :if => os[:family] == 'redhat' do
  it { should be_enabled }
  it { should be_running }
end
