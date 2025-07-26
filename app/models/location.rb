# typed: strict

class Location < ApplicationRecord
  validates :address, presence: true, uniqueness: { case_sensitive: false }
end
