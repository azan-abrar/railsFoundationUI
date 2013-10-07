class UsersController < ApplicationController

  before_filter :get_company

  def new
    @user = User.new
    if @employee_register.blank?
      @user.build_employee
      @user.employee.email = @company.email
      @user.employee.mobile_phone = @company.phone
    end 
    respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @user }
      end
    end

    def create
      @user = User.new(params[:user])
      if @employee_register.blank?
        @user.employee.company_id = @company.id
        @user.roles = [:company_administrator]
      end

      respond_to do |format|
        if @user.save
          if @employee_register.blank?
            @user.employee.activate!
            @company.access_token = nil
            @company.save
          else
            @user.employee = @employee_register
            @user.employee.access_token = nil
            @user.save
          end
          logout
          login(@user.username, params[:user][:password], true)
          redirect_to "/#/employees" and return
        else
          render action: "new" and return
        end
      end
    end

    private

    def get_company
      @company = Company.find_by_access_token(params[:access_token])
      @employee_register = Employee.find_by_access_token(params[:access_token]) if @company.blank?
      redirect_to "/#/login" and return if @company.blank? && @employee_register.blank?
    end

  end
