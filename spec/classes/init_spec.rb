require 'spec_helper'
describe 'udev' do

  context 'with defaults for all parameters' do
    it { should contain_class('udev') }
  end
end
