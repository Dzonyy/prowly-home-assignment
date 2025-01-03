class CompaniesController < ApplicationController
  def create
    company = Company.new(company_params)
    if company.save
      render json: company, status: :created
    else
      render json: company.errors, status: :unprocessable_entity
    end
  end

  def create_from_csv
    return unless params[:file]

    result = Companies::CreateFromCsvService.call(file: params[:file])

    if result[:success]
      render json: result[:companies], status: :created
    else
      render json: result[:errors], status: :unprocessable_entity
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, addresses_attributes: [:address_line1, :address_line2, :city, :state, :zip, :country])
  end
end
