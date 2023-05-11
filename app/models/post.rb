class Post < ApplicationRecord

  belongs_to :end_user
  belongs_to :category

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
      @post = Post.where("title LIKE? or introduction LIKE?", "#{word}")
    elsif search == "partial_match"
      @post = Post.where("title LIKE? or introduction LIKE?", "%#{word}%")
    else
      @post = Post.all
    end
  end

end
