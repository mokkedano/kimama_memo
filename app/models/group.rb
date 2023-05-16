class Group < ApplicationRecord

  # end_userモデルとのアソシエーション
  # groupsテーブルから中間テーブル(group_users)に対する関連付け
  has_many :group_users, dependent: :destroy
  # groupsテーブルから中間テーブル(group_users)を介してend_usersテーブルへの関連付け
  has_many :end_users, through: :group_users


  has_one_attached :group_image


  validates :name, presence: true, length: { minimum: 1, maximum: 20 }
  validates :introduction, length: { maximum: 50 }




  def get_group_image(width, height)
    unless group_image.attached?
      file_path = Rails.root.join('app/assets/images/gorilla.jpg')
      group_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    group_image.variant(resize_to_limit: [width, height]).processed
  end

end
