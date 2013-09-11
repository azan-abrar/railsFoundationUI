require 'test_helper'

class EmployeesControllerTest < ActionController::TestCase
  setup do
    @employee = employees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:employees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create employee" do
    assert_difference('Employee.count') do
      post :create, employee: { dob: @employee.dob, email: @employee.email, first_name: @employee.first_name, is_married: @employee.is_married, job_id: @employee.job_id, job_status: @employee.job_status, join_date: @employee.join_date, last_name: @employee.last_name, middle_name: @employee.middle_name, permanent_address: @employee.permanent_address, phone_1: @employee.phone_1, phone_2: @employee.phone_2, resume: @employee.resume, secondary_address: @employee.secondary_address }
    end

    assert_redirected_to employee_path(assigns(:employee))
  end

  test "should show employee" do
    get :show, id: @employee
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @employee
    assert_response :success
  end

  test "should update employee" do
    put :update, id: @employee, employee: { dob: @employee.dob, email: @employee.email, first_name: @employee.first_name, is_married: @employee.is_married, job_id: @employee.job_id, job_status: @employee.job_status, join_date: @employee.join_date, last_name: @employee.last_name, middle_name: @employee.middle_name, permanent_address: @employee.permanent_address, phone_1: @employee.phone_1, phone_2: @employee.phone_2, resume: @employee.resume, secondary_address: @employee.secondary_address }
    assert_redirected_to employee_path(assigns(:employee))
  end

  test "should destroy employee" do
    assert_difference('Employee.count', -1) do
      delete :destroy, id: @employee
    end

    assert_redirected_to employees_path
  end
end
