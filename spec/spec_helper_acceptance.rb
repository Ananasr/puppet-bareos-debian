require 'beaker-rspec'
require 'beaker/puppet_install_helper'

run_puppet_install_helper

RSpec.configure do |c|
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  c.formatter = :documentation

  c.before :suite do
    hosts.each do |host|
      copy_module_to(host, :source => proj_root, :module_name => 'bareos')
      on host, puppet('module', 'install', 'puppetlabs-stdlib'), {:acceptable_exit_codes => [0]}
      on host, puppet('module', 'install', 'puppetlabs-apt'), {:acceptable_exit_codes => [0]}
      on host, puppet('module', 'install', 'puppetlabs-mysql'), {:acceptable_exit_codes => [0]}
      on host, puppet('module', 'install', 'puppet-staging'), {:acceptable_exit_codes => [0]}
    end
  end
end
