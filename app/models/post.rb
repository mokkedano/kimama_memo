class Post < ApplicationRecord

  belongs_to :end_user
  belongs_to :category

end
