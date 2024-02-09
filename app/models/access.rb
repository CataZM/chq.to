class Access < ApplicationRecord
  belongs_to :link
  validates :ip_address, presence: true, format: { with: /\A(?:[0-9]{1,3}\.){3}[0-9]{1,3}\z/ }
end
