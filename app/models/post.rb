class Post < ApplicationRecord
  validates( :title, presence: true )
  validates( :body, presence: true )

  belongs_to( :user )
  belongs_to( :category )

  has_many( :post_tags )
  has_many( :tags, through: :post_tags )
end
