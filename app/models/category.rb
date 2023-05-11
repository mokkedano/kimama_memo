class Category < ApplicationRecord

  has_many :posts, dependent: :destroy

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
