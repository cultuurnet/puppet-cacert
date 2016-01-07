require 'spec_helper'

describe 'cacert' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "cacert class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('cacert::params') }
          it { is_expected.to contain_class('cacert::install').that_comes_before('cacert::config') }
          it { is_expected.to contain_class('cacert::config') }
          it { is_expected.to contain_class('cacert::service').that_subscribes_to('cacert::config') }

          it { is_expected.to contain_service('cacert') }
          it { is_expected.to contain_package('cacert').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'cacert class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('cacert') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
