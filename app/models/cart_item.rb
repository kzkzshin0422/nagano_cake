class CartItem < ApplicationRecord
  
  belongs_to :items, dependent: :destroy
end
