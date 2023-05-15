class Post < ApplicationRecord

  belongs_to :end_user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  # categoriesモデルとのアソシエーション
  # postsテーブルから中間テーブル(post_category_relations)に対する関連付け
  has_many :post_category_relations, dependent: :destroy
  # postsテーブルから中間テーブル(post_category_relations)を介してcategoriesテーブルへの関連付け
  has_many :categories, through: :post_category_relations, dependent: :destroy


  has_one_attached :image


  validates :title, presence: true, length: { minimum: 1, maximum: 30 }
  validates :introduction, presence: true
  # validates :image, presence: true



  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image_post.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end


  # 検索方法の分岐に関する記述
  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("title LIKE(?) or introduction LIKE(?)", "#{word}", "#{word}")
    elsif search == "partial_match"
      @post = Post.where("title LIKE(?) or introduction LIKE(?)", "%#{word}%", "%#{word}%")
    else
      @post = Post.all
    end
  end


  # いいね機能に関するメソッド
  def favorited_by?(end_user)
    favorites.exists?(end_user_id: end_user.id)
  end


  # カテゴリ保存に関するメソッド
  def save_category(sent_categories)
    # カテゴリが存在していれば、カテゴリの名前を配列として全て取得
    current_categories = self.categories.pluck(:name) unless self.categories.nil?
    # 現在取得したカテゴリから送られてきたカテゴリを除いてoldcategoryとする
    old_categories = current_categories - sent_categories
    # 送信されてきたカテゴリから現在存在するカテゴリを除いたカテゴリをnewとする
    new_categories = sent_categories - current_categories

    # 古いカテゴリを消す
    old_categories.each do |old|
      self.categories.delete　Category.find_by(name: old)
    end

    # 新しいカテゴリを保存
    new_categories.each do |new|
      new_post_category = Category.find_or_create_by(name: new)
      post_categories.new(end_user_id: end_user_id, category_id: new_post_category.id).save
    end
  end


end

