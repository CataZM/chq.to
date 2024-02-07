class AddPasswordToLinkRegulars < ActiveRecord::Migration[7.1]
  def change
    add_column :link_regulars, :password, :string
  end
end
