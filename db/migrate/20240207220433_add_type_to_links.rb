class AddTypeToLinks < ActiveRecord::Migration[7.1]
  def change
    add_column :links, :type, :string
  end
end
