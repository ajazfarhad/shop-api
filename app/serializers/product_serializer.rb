# frozen_string_literal: true
class ProductSerializer < ActiveModel::Serializer
  attributes :title, :price
  has_many :reviews, each_serializer: ReviewSerializer
end
