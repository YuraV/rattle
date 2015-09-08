class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.integer :category_id
      t.integer :user_id
      t.boolean :published, default: true

      t.timestamps
    end
  end
end
