class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title
      t.string :description
      t.integer :user_id
      t.boolean :published, default: true

      t.timestamps
    end
  end
end
