class GroupUser < ApplicationRecord

  belongs_to :group
  belongs_to :end_user

end
