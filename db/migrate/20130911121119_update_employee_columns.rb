class UpdateEmployeeColumns < ActiveRecord::Migration
  def change
    add_column :employees, :designation, :string
  end
end
