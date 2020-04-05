require 'dockerspec/serverspec'

describe 'docker-ci' do
  describe docker_build('.') do

    it { should have_maintainer /Antoine Benevaut/ }
    it { should have_cmd ['/bin/sh'] }

    before(:all) do
      image = Docker::Image.build_from_dir('.')

      set :os, family: :debian
      set :backend, :docker
      set :docker_image, image.id
    end

    it "installs the right version of Ubuntu" do
      expect(os_version).to include("Ubuntu 14")
    end

    def os_version
      command("lsb_release -a").stdout
    end

    describe docker_run(described_image) do
      describe file('/etc/httpd.conf') do
        it { should be_file }
        it { should contain 'ServerName www.example.jp' }
      end
    end

  end
end
