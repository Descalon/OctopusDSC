require 'spec_helper'

describe file('c:/Octopus') do
  it { should be_directory }
end

describe file('c:/Applications') do
  it { should be_directory }
end

describe file('C:/Program Files/Octopus Deploy/Tentacle/Tentacle.exe') do
  it { should_not exist }
end

describe service('OctopusDeploy Tentacle') do
  it { should_not be_installed }
end

describe command('$ProgressPreference = "SilentlyContinue"; try { Get-DSCConfiguration -ErrorAction Stop; write-output "Get-DSCConfiguration succeeded"; $true } catch { write-output "Get-DSCConfiguration failed"; write-output $_; $false }') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match /Get-DSCConfiguration succeeded/ }
end

describe command('$ProgressPreference = "SilentlyContinue"; try { if (-not (Test-DSCConfiguration -ErrorAction Stop)) { write-output "Test-DSCConfiguration returned false"; exit 1 } write-output "Test-DSCConfiguration succeeded"; exit 0 } catch { write-output "Test-DSCConfiguration failed"; write-output $_; exit 2 }') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match /Test-DSCConfiguration succeeded/ }
end
