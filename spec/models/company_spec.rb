require 'rails_helper'

RSpec.describe Company, type: :model do
  it { should have_many(:addresses).dependent(:destroy) }
  it { should accept_nested_attributes_for(:addresses) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:registration_number) }

  let!(:existing_company) { Company.create!(name: "Existing Company", registration_number: "123456") }

  it { should validate_uniqueness_of(:registration_number).case_insensitive }
end
