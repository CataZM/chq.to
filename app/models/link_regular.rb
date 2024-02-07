class LinkRegular < ApplicationRecord
  belongs_to :user
  has_many :accesses, as: :link
end
