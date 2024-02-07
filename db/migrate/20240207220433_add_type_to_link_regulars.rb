class AddTypeToLinkRegulars < ActiveRecord::Migration[7.1]
  def change
    add_column :link_regulars, :type, :string
  end
end
