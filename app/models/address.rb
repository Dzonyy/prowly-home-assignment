class Address < ApplicationRecord
  belongs_to :company

  validates :city, :street, :country, presence: true
end
