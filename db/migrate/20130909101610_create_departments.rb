class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :uuid
      t.string :name
      t.string :description
      t.boolean :is_deleted, :default => false
      t.belongs_to :company
      
      t.timestamps
    end
    
    add_index :departments, :uuid, :unique => true
  end
end
