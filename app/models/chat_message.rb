class ChatMessage < ApplicationRecord

  belongs_to :group
  belongs_to :end_user


  validates :message, presence: true, length: { minimum: 1, maximum: 300 }


end
