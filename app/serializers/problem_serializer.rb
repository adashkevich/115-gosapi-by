class ProblemSerializer < ActiveModel::Serializer
  has_many :answers

  attributes :id, :href, :address, :crm_create_at, :organization_id, :status, :description
end