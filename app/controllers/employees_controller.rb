class EmployeesController < ApplicationController

  before_filter :get_employee, :only => [:show, :edit, :update, :destroy]
  before_filter :refine_employee_hash, :only => [:create, :update]
  
  def index
    @employees_hash, @employees = Employee.get_employees(params)
    if @employees_hash.blank?
      render json: {error: "No records found."}.to_json, status: 500 and return
    else
      render partial: 'index', formats: [:json], layout: false, status: 200 and return
    end
  end

  def show
    @employee = Employee.find_by_uuid(params[:id])
    render json: @employee.employee_hash, status: 200 and return
  end

  def new
    @employee = Employee.new
    render json: @employee, status: 200 and return
  end

  def edit
    @employee = Employee.find_by_uuid(params[:id])
    render json: @employee.employee_hash, status: 200 and return
  end

  def create
    @employee = Employee.new(params[:employee])
    if @employee.save
      render json: @employee.employee_hash, status: :created and return
    else
      render json: @employee.errors.full_messages.to_json, status: :unprocessable_entity and return
    end
  end

  def update
    @employee = Employee.find_by_uuid(params[:id])
    if @employee.update_attributes(params[:employee])
      render json: @employee.employee_hash, status: 200 and return
    else
      render json: @employee.errors.full_messages.to_json, status: :unprocessable_entity and return
    end
  end

  def destroy
    @employee = Employee.find_by_uuid(params[:id])
    @employee.delete!
    render json: {success: "Successfully deleted employee #{@employee.full_name}"}, status: 200 and return
  end
  
  def get_employee_constants
    employee_constants = {
      designations: [{name: '- Select Designation -', value: ''}],
      job_status: [{name: '- Select Job Status -', value: ''}],
      department_ids: [{name: '- Select Department -', value: ''}]
    }
    Employee::DESIGNATION_ARRAY.each{|des| employee_constants[:designations] << {name: des, value: des} }
    Department.all.each{|dep| employee_constants[:department_ids] << {name: dep.name, value: dep.id} }
    Employee::JOB_STATUS_ARRAY.each{|job| employee_constants[:job_status] << {name: job, value: job} }
    render json: employee_constants.to_json, status: 200 and return
  end
  
  private
  
  def get_employee
    @employee = Employee.find_by_uuid(params[:id])
    render json: {error: "Employee not found."}, status: 400 and return if @employee.blank?
  end
  
  def refine_employee_hash
    params[:employee].delete(:id)
    params[:employee].delete(:full_name)
    params[:employee].delete(:department_name)
  end
  
end
