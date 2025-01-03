require 'csv'

module Companies
  class CreateFromCsvService
    def self.call(file:)
      new(file).call
    end

    def initialize(file)
      @file = file
      @errors = []
      @companies = []
    end

    def call
      CSV.foreach(@file.path, headers: true) do |row|
        company = Company.find_or_initialize_by(registration_number: row['registration_number'])
        company.name = row['name']
        company.addresses.build(
          street: row['street'],
          city: row['city'],
          postal_code: row['postal_code'],
          country: row['country']
        )

        unless company.save
          @errors << company.errors.full_messages
        else
          @companies << company
        end
      end

      { success: @errors.empty?, companies: @companies, errors: @errors }
    end
  end
end
