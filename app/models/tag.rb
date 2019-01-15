class Tag < ApplicationRecord
  validates( :name, presence: true, uniqueness: true )

  belongs_to( :user )

  has_many( :post_tags )
  has_many( :posts, through: :post_tags )
end
