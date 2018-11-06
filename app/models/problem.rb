class Problem < ApplicationRecord

  has_one :category
  has_many :photos
  belongs_to :user
  has_many :change_logs
  has_many :answers

  scope :last_updated, -> { joins('INNER JOIN "change_logs" ON "change_logs"."id" = (SELECT "id" FROM "change_logs"  WHERE "problem_id" = "problems"."id" AND "field"=\'status\' ORDER BY change_date DESC LIMIT 1)') }
  scope :first_updated, -> { joins('INNER JOIN "change_logs" ON "change_logs"."id" = (SELECT "id" FROM "change_logs"  WHERE "problem_id" = "problems"."id" AND "field"=\'status\' ORDER BY change_date DESC LIMIT 1)') }
end
