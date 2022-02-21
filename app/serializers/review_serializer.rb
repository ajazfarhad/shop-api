class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :name, :message, :rate
end
