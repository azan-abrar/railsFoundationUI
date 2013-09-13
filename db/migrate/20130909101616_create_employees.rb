class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :uuid
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :email
      t.string :designation
      t.belongs_to :department
      t.string :job_status
      t.string :resume
      t.date :dob
      t.boolean :is_married, :default => false
      t.datetime :join_date
      
      t.string :permanent_address
      t.string :permanent_city
      t.string :permanent_postal_code
      
      t.string :secondary_address
      t.string :secondary_city
      t.string :secondary_postal_code
      
      t.string :mobile_phone
      t.string :home_phone
      t.boolean :is_deleted, :default => false

      t.timestamps
    end
    
    add_index :employees, :uuid, :unique => true
    add_index :employees, :designation
    add_index :employees, :first_name
    add_index :employees, :middle_name
    add_index :employees, :last_name
    add_index :employees, :email
    add_index :employees, :mobile_phone
  end
end
