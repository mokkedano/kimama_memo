class Category < ApplicationRecord

  #categoriesテーブルから中間テーブル(post_category_relations)に対する関連付け
  has_many :post_category_relations, dependent: :destroy
  #categoriesテーブルから中間テーブル(post_category_relations)を介してpostsテーブルへの関連付け
  has_many :posts, through: :post_category_relations, dependent: :destroy

  #categoriesテーブルから中間テーブル(post_category_relations)を介してend_usersテーブルへの関連付け
  has_many :end_users, through: :category_relations


  validates :name, presence: true, length: { minimum: 1, maximum: 20 }


end
