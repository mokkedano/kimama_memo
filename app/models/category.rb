class Category < ApplicationRecord

  has_many :posts, dependent: :destroy

  validates :name, presence: true, length: { minimum: 1, maximum: 20 }

end
