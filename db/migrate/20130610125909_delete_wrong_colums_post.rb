class DeleteWrongColumsPost < ActiveRecord::Migration
  def change
    remove_column :posts, :commentable_id
    remove_column :posts, :commentable_type
  end
end
