class Link < ApplicationRecord
  belongs_to :user
  has_many :accesses, as: :link
  attribute :type, :string
end
