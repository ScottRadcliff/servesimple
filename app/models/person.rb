class Person < ActiveRecord::Base

  belongs_to :account
  has_and_belongs_to_many :roles

  validates :name, presence: true

end
