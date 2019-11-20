class Relationship < ApplicationRecord
  belongs_to :owner
  has_many :job_offers
end
