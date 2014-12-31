class Person < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, request_keys: [:subdomain]

  belongs_to :account
  has_and_belongs_to_many :roles

  validates :name, presence: true

  # Override Devise's method of finding to scope to account
  def self.find_for_authentication(warden_conditions)
    account = Account.find_by_subdomain(warden_conditions[:subdomain])
    where(:email => warden_conditions[:email], :account => account).first
  end

end
