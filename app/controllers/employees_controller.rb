class EmployeesController < ApplicationController

  def index
    @employees = Employee.get_employees
    render json: @employees, status: 200 and return
  end

  def show
    @employee = Employee.find(params[:id])
    render json: @employee.employee_hash, status: 200 and return
  end

  def new
    @employee = Employee.new
    render json: @employee, status: 200 and return
  end

  def edit
    @employee = Employee.find(params[:id])
    render json: @employee, status: 200 and return
  end

  def create
    @employee = Employee.new(params[:employee])
    if @employee.save
      render json: @employee, status: :created and return
    else
      render json: @employee.errors.full_messages.to_json, status: :unprocessable_entity and return
    end
  end

  def update
    @employee = Employee.find(params[:id])

    respond_to do |format|
      if @employee.update_attributes(params[:employee])
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy

    respond_to do |format|
      format.html { redirect_to employees_url }
      format.json { head :no_content }
    end
  end
end
