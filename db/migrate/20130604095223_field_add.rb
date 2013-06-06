class FieldAdd < ActiveRecord::Migration
  def change
    add_column :posts, :confirmed, :integer, :null => false, :default => 0

  end
end
