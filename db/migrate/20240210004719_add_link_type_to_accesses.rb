class AddLinkTypeToAccesses < ActiveRecord::Migration[7.1]
  def change
    add_column :accesses, :link_type, :string
  end
end
