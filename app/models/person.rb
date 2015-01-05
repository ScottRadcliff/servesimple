require 'elasticsearch/model'

class Person < ActiveRecord::Base
  # ElasticSearch-specific
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  index_name "people_#{Rails.env}"
  # __elasticsearch__.client = Elasticsearch::Client.new log: true
  # __elasticsearch__.client.transport.logger.formatter = proc { |s, d, p, m| "\e[32m#{m}\n\e[0m" }

  settings index: { number_of_shards: 5, number_of_replicas: 0 } do
    mappings dynamic: 'true' do
      indexes :name, type: 'string', index: 'analyzed', fields: { raw: { type: 'string', index: :not_analyzed } }
      indexes :gender, type: 'string', index: :not_analyzed
      indexes :roles, type: 'nested' do
        indexes :name, index: :not_analyzed
      end
    end
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, request_keys: [:subdomain]

  belongs_to :account
  has_and_belongs_to_many :roles

  validates :name, presence: true
  validates_uniqueness_of :email, allow_blank: true, if: :email_changed?, scope: :account_id

  # Override Devise's method of finding to scope to account
  def self.find_for_authentication(warden_conditions)
    account = Account.find_by_subdomain(warden_conditions[:subdomain])
    where(:email => warden_conditions[:email], :account => account).first
  end

  def as_indexed_json(options = {})
    self.as_json(include: { roles: { only: :name } })
  end

end
