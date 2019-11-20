class Owner < ApplicationRecord
  has_many :relationships

  validates :name, presence: true
end
