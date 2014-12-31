require 'rails_helper'

RSpec.describe Person, :type => :model do
  describe 'validations' do
    let(:account) { create(:account, subdomain: 'fft') }
    let(:account_2) { create(:account, subdomain: 'idhc') }
    let(:person) { create(:person, account: account) }

    it { should validate_presence_of :name }

    it 'should require unique email addresses' do
      expect(build(:person, account: account, email: person.email)).to_not be_valid
    end

    it 'should allow the same email address across different accounts' do
      expect(build(:person, account: account_2, email: person.email)).to be_valid
    end
  end
end
