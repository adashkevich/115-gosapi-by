class Problem < ApplicationRecord

  has_one :category
  has_many :photos
  belongs_to :user
end
