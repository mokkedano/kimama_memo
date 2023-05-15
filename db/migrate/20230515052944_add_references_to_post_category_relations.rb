class AddReferencesToPostCategoryRelations < ActiveRecord::Migration[6.1]
  def change
    add_reference :post_category_relations, :end_user, null: false, foreign_key: true
  end
end
