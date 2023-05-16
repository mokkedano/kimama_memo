class CreateChatMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :chat_messages do |t|
      t.text :message, null: false
      t.references :group, foreign_key: true
      t.references :end_user, foreign_key: true

      t.timestamps
    end
  end
end
