class DepartmentsController < ApplicationController
  
  before_filter :get_department, :only => [:show, :edit, :update, :destroy]
  before_filter :refine_department_hash, :only => [:create, :update]
  
  def index
    @departments_hash, @departments = Department.get_departments(params)
    if @departments_hash.blank?
      render json: {error: "No records found."}.to_json, status: 500 and return
    else
      render partial: 'index', formats: [:json], layout: false, status: 200 and return
    end
  end

  def show
    render json: @department.department_hash, status: 200 and return
  end

  def new
    @department = Department.new
    render json: @department, status: 200 and return
  end

  def edit
    render json: @department.department_hash, status: 200 and return
  end

  def create
    @department = Department.new(params[:department])
    if @department.save
      render json: @department.department_hash, status: :created and return
    else
      render json: @department.errors.full_messages.to_json, status: :unprocessable_entity and return
    end
  end

  def update
    if @department.update_attributes(params[:department])
      render json: @department.department_hash, status: 200 and return
    else
      render json: @department.errors.full_messages.to_json, status: :unprocessable_entity and return
    end
  end

  def destroy
    #@department.delete!
    render json: {success: "Successfully deleted department #{@department.department}"}, status: 200 and return
  end
  
  private
  
  def get_department
    @department = Department.find_by_uuid(params[:id])
    render json: {error: "Department not found."}, status: 400 and return if @department.blank?
  end
  
  def refine_department_hash
    params[:department].delete(:id)
  end
  
end
