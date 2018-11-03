class Problem < ApplicationRecord

  has_one :category
  has_many :photos
  belongs_to :user
  has_many :change_logs
  has_many :answers
end
