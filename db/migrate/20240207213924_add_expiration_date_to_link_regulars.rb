class AddExpirationDateToLinkRegulars < ActiveRecord::Migration[7.1]
  def change
    add_column :link_regulars, :expiration_date, :datetime
  end
end
