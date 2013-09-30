class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :uuid
      t.string :employee_id
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :email
      t.string :gender
      t.string :designation
      t.belongs_to :department
      t.belongs_to :company
      t.belongs_to :user
      t.boolean :status, :default => false;
      t.attachment :resume
      t.date :dob
      t.boolean :is_married, :default => false
      t.datetime :join_date
      
      t.string :permanent_country_code
      t.string :permanent_address
      t.string :permanent_city
      t.string :permanent_state
      t.string :permanent_postal_code
      
      t.string :secondary_country_code
      t.string :secondary_address
      t.string :secondary_city
      t.string :secondary_state
      t.string :secondary_postal_code
      
      t.string :mobile_phone
      t.string :home_phone
      t.boolean :is_deleted, :default => false
      t.string :access_token

      t.timestamps
    end
    
    add_index :employees, :uuid, :unique => true
    add_index :employees, :designation
    add_index :employees, :first_name
    add_index :employees, :middle_name
    add_index :employees, :last_name
    add_index :employees, :email
    add_index :employees, :mobile_phone
    add_index :companies, :access_token
  end
end
