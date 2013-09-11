class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :email
      t.belongs_to :job
      t.string :job_status
      t.string :resume
      t.date :dob
      t.boolean :is_married, :default => false
      t.datetime :join_date
      t.string :permanent_address
      t.string :secondary_address
      t.string :phone_1
      t.string :phone_2

      t.timestamps
    end
  end
end
