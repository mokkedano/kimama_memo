class Category < ApplicationRecord

  #categoriesテーブルから中間テーブル(post_category_relations)に対する関連付け
  has_many :post_category_relations, dependent: :destroy
  #categoriesテーブルから中間テーブルル(post_category_relations)を介してpostsテーブルへの関連付け
  has_many :posts, through: :post_category_relations, dependent: :destroy


  validates :name, presence: true, length: { minimum: 1, maximum: 20 }



  # 検索方法の分岐に関する記述
  def self.looks(search, word)
    if search == "perfect_match"
      @category = Category.where("name LIKE?", "#{word}")
    elsif search == "partial_match"
      @category = Category.where("name LIKE?", "%#{word}%")
    else
      @category = Category.all
    end
  end

end
