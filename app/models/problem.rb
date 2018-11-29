class Problem < ApplicationRecord

  has_many :photos
  has_many :change_logs
  has_many :answers

  # belongs_to :city
  # has_one :category
  # belongs_to :user

  after_create do
    ChangeLog.create field: 'status', old: nil, new: status, problem_id: id
  end

  scope :joins_last_status, -> { joins('INNER JOIN change_logs AS cl ON cl.id = (SELECT id FROM change_logs  WHERE problem_id = problems.id AND field=\'status\' ORDER BY change_date DESC LIMIT 1)') }
end
