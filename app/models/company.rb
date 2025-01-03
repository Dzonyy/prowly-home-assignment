class Company < ApplicationRecord
  has_many :addresses, dependent: :destroy
  accepts_nested_attributes_for :addresses

  validates :name, :registration_number, presence: true
  validates :registration_number, uniqueness: true
end
