class RemoveImageFromPosts < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :image, :text
  end
end
