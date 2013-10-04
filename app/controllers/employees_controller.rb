class EmployeesController < ApplicationController

  before_filter :get_employee, :only => [:show, :edit, :update, :destroy, :upload_resume, :upload_profile_picture]
  before_filter :refine_employee_hash, :only => [:create, :update]
  
  def index
    @employees_hash, @employees = Employee.get_employees(params, current_user.employee.company, current_user)
    if @employees_hash.blank?
      render json: {error: "No records found."}.to_json, status: 500 and return
    else
      render partial: 'index', formats: [:json], layout: false, status: 200 and return
    end
  end

  def show
    render json: @employee.employee_hash(current_user), status: 200 and return
  end

  def new
    @employee = Employee.new
    render json: @employee, status: 200 and return
  end

  def edit
    render json: @employee.employee_hash(current_user), status: 200 and return
  end

  def create
    begin
      @employee = Employee.new(params[:employee])
      @employee.comapny_id = current_user.employee.company.id
      if @employee.save
        render json: @employee.employee_hash(current_user), status: :created and return
      else
        render json: @employee.errors.full_messages.to_json, status: :unprocessable_entity and return
      end
    rescue Exception=>e
      render json: ["Something went wrong on server. Try after sometime or contact you administrator"].to_json, status: :unprocessable_entity and return
    end
  end

  def update
    begin
      if @employee.update_attributes(params[:employee])
        render json: @employee.employee_hash(current_user), status: 200 and return
      else
        render json: @employee.errors.full_messages.to_json, status: :unprocessable_entity and return
      end
    rescue Exception=>e
      render json: ["Something went wrong on server. Try after sometime or contact you administrator"].to_json, status: :unprocessable_entity and return
    end
  end

  def upload_resume
    if !params[:employee].blank? && !params[:employee][:resume].blank?
      @employee.resume = params[:employee][:resume]
      @employee.save
    end
    redirect_to "/#/employee/#{@employee.uuid}" and return
  end

  def upload_profile_picture
    if !params[:employee].blank? && !params[:employee][:profile_picture].blank?
      @employee.profile_picture = params[:employee][:profile_picture]
      @employee.save
    end
    redirect_to "/#/employee/#{@employee.uuid}" and return
  end

  def destroy
    @employee.delete!
    render json: {success: "Successfully deleted employee #{@employee.full_name}"}, status: 200 and return
  end
  
  def get_employee_constants
    employee_constants = {
      genders: [],
      status: [{name: "Disabled", value: false}, {name: "Enabled", value: true}],
      marital_status: [{name: "Single", value: false}, {name: "Married", value: true}],
      department_ids: [],
      countries: []
    }
    Employee::GENDER_ARRAY.each{|des| employee_constants[:genders] << {name: des, value: des} }
    current_user.employee.company.departments.each{|dep| employee_constants[:department_ids] << {name: dep.name, value: dep.id} }
    Carmen::Country.all.each{|country| employee_constants[:countries] << {name: country.name, value: country.code} }
    render json: employee_constants.to_json, status: 200 and return
  end
  
  private
  
  def get_employee
    @employee = Employee.find_by_uuid(params[:id]) || Employee.find_by_employee_id(params[:id])
    render json: {error: "Employee not found."}, status: 400 and return if @employee.blank?
  end
  
  def refine_employee_hash
    params[:employee].delete(:id)
    params[:employee].delete(:full_name)
    params[:employee].delete(:department_name)
    params[:employee].delete(:permanent_country_name)
    params[:employee].delete(:secondary_country_name)
    params[:employee].delete(:resume)
    params[:employee].delete(:resume_name)
    params[:employee].delete(:created_at)
    params[:employee].delete(:resume_content_type)
    params[:employee].delete(:resume_file_name)
    params[:employee].delete(:resume_file_size)
    params[:employee].delete(:resume_updated_at)
    params[:employee].delete(:updated_at)
    params[:employee].delete(:is_admin)
    params[:employee].delete(:is_owner)
    params[:employee].delete(:profile_picture_mini)
    params[:employee].delete(:profile_picture_thumb)
  end
  
end
