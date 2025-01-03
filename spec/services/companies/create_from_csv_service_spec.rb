require 'rails_helper'

RSpec.describe Companies::CreateFromCsvService, type: :service do
  describe '.call' do
    let(:file) { fixture_file_upload('companies.csv', 'text/csv') }
    let(:service) { described_class.call(file: file) }

    context 'when the CSV file is valid' do
      it 'creates companies from the CSV file' do
        expect { service }.to change { Company.count }.by(2)
      end

      it 'returns success' do
        expect(service[:success]).to be true
      end

      it 'returns the created companies' do
        expect(service[:companies].size).to eq(2)
      end

      it 'does not return any errors' do
        expect(service[:errors]).to be_empty
      end
    end

    context 'when the CSV file is invalid' do
      let(:file) { fixture_file_upload('invalid_companies.csv', 'text/csv') }

      it 'does not create any companies' do
        expect { service }.not_to change { Company.count }
      end

      it 'returns failure' do
        expect(service[:success]).to be false
      end

      it 'returns errors' do
        expect(service[:errors]).not_to be_empty
      end
    end
  end
end
