require 'dockerspec'
require 'dockerspec/serverspec'

describe docker_build(path: '.') do

    it { should have_maintainer /Antoine Benevaut/ }
    it { should have_cmd '/bin/sh' }

    describe docker_run(described_image) do

        describe 'OpenSSL' do
            describe package('openssl') do
                it { should be_installed }
            end

            it 'has openssl in the path' do
                expect(command('which openssl').exit_status).to eq 0
            end
        end

        describe service('docker') do
            it { should be_enabled }
            it { should be_running }
        end

        describe package('docker-compose') do
            it { should be_installed }
        end

    end
end
