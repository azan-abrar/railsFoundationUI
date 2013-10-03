class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :website
      t.attachment :logo
      t.string :email
      t.string :phone
      t.string :access_token
      t.string :slug

      t.timestamps
    end

    add_index :companies, :slug, unique: true
    add_index :companies, :access_token
  end
end
