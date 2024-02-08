class CreateLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :links do |t|
      t.string :name
      t.string :slug
      t.string :url
      t.integer :access_count
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :links, :slug, unique: true
  end
end
