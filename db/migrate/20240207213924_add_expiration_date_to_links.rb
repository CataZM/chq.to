class AddExpirationDateToLinks < ActiveRecord::Migration[7.1]
  def change
    add_column :links, :expiration_date, :datetime
  end
end
