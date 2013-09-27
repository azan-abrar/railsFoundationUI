class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :website
      t.attachment :logo
      t.string :slug

      t.timestamps
    end

    add_index :companies, :slug, unique: true
  end
end
