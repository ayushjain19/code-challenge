class CompaniesController < ApplicationController
  before_action :set_company, except: [:index, :create, :new]

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def show
  end

  def company_validation
    if @company.errors.present? && @company.errors.messages[:email].present?
      flash.now[:alert] = @company.errors.messages[:email][0]
    end
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to companies_path, notice: "Saved"
    else
      company_validation
      render :new
    end
  end

  def edit
  end

  def update
    if @company.update(company_params)
      redirect_to companies_path, notice: "Changes Saved"
    else
      company_validation
      render :edit
    end
  end  

  def destroy
    if @company.destroy
      redirect_to companies_path, notice: "Company Deleted"
    end
  end

  private

  def handle_city_and_state(permitted_params)
    zipcode_data = ZipCodes.identify(permitted_params["zip_code"])
    if zipcode_data.nil?
      permitted_params["city"] = nil
      permitted_params["state"] = nil
    else
      permitted_params["city"] = zipcode_data[:city]
      permitted_params["state"] = zipcode_data[:state_code]
    end
    permitted_params
  end

  def company_params
    permitted_params = params.require(:company).permit(
      :name,
      :legal_name,
      :description,
      :zip_code,
      :phone,
      :email,
      :owner_id,
    )
    return handle_city_and_state(permitted_params)
  end

  def set_company
    @company = Company.find(params[:id])
  end
  
end
