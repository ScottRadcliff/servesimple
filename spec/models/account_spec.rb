require 'rails_helper'

RSpec.describe Account, :type => :model do
  describe 'validations' do
    it { should validate_presence_of :subdomain }
    it { should validate_uniqueness_of :subdomain }

    it { should allow_value('fft').for(:subdomain) }
    it { should allow_value('idhc').for(:subdomain) }

    it { should_not allow_value('www').for(:subdomain) }
    it { should_not allow_value('WWW').for(:subdomain) }
    it { should_not allow_value('fft.').for(:subdomain) }

    it 'should validate case insensitive uniqueness' do
      create(:account, subdomain: 'fft')
      expect(build(:account, subdomain: 'fft')).to_not be_valid
    end
  end
end
