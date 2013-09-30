class UsersController < ApplicationController

  before_filter :get_company

  def new
    @user = User.new
    @user.build_employee
    @departments = @company.departments

    respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @user }
      end
    end

    def create
      @user = User.new(params[:user])
      @user.employee.company_id = @company.id
      @user.roles = [:company_administrator]

      respond_to do |format|
        if @user.save
          @company.access_token = nil
          @company.save
          logout
          login(@user.username, params[:user][:password], true)
          redirect_to "/#/employees" and return
        else
          @departments = @company.departments
          render action: "new" and return
        end
      end
    end

    private

    def get_company
      @company = Company.find_by_access_token(params[:access_token])
      redirect_to "/#/login" and return if @company.blank?
    end

  end
