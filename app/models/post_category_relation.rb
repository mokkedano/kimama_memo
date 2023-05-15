class PostCategoryRelation < ApplicationRecord

  belongs_to :post
  belongs_to :category
  belongs_to :end_user

  validates :post_id, presence: true
  validates :category_id, presence: true
  validates :end_user_id, presence: true

end
