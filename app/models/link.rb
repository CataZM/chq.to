class Link < ApplicationRecord
  belongs_to :user
  has_many :accesses, as: :link
  attribute :type, :string
  validates :name, presence: true
  validates :url, presence: true, format: { with: URI.regexp }
  validates :type, inclusion: { in: %w(Link Temporal Efimero Privado), message: "%{value} no es un tipo de enlace válido" }
  validates :password, presence: true, if: -> { type == 'Privado' }
  validates :expiration_date, presence: true, if: -> { type == 'Temporal' }
  validates :slug, presence: true, uniqueness: true
end
