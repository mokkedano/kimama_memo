class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  # categoryモデルとのアソシエーション
  # end_usersテーブルから中間テーブル(post_category_relations)に対する関連付け
  has_many :post_category_relations, dependent: :destroy
  # end_usersテーブルから中間テーブル(post_category_relations)を介してcategoriesテーブルへの関連付け
  has_many :categories, through: :post_category_relations


  has_one_attached :profile_image


  validates :nickname, presence: true, length: { minimum: 1, maximum: 20 }
  validates :self_introduction, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: true




  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end


  # ユーザーの退会確認に関するメソッド
  def active_for_authentication?
    super && (is_deleted == false)
  end


  # ゲストユーザーログインに関するメソッド
  def self.guest
    find_or_create_by!(nickname: 'guest_end_user' ,email: 'guest@example.com') do |end_user|
      end_user.password = SecureRandom.urlsafe_base64
      end_user.nickname = "guest_end_user"
    end
  end


end
