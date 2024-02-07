class AddAccessedToLinkRegulars < ActiveRecord::Migration[7.1]
  def change
    add_column :link_regulars, :accessed, :boolean
  end
end
