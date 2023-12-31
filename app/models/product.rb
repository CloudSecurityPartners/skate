class Product < ApplicationRecord
    has_many :reviews
    has_many :product_subscriptions
    has_one_attached :thumbnail

    belongs_to :product_category
end
