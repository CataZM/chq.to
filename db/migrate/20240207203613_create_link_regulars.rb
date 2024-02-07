class CreateLinkRegulars < ActiveRecord::Migration[7.1]
  def change
    create_table :link_regulars do |t|
      t.string :name
      t.string :slug
      t.string :url
      t.integer :access_count
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :link_regulars, :slug, unique: true
  end
end
