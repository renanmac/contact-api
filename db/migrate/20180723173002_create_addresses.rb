class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city
      t.string :state
      t.string :country
      t.string :code
      t.references :contact, foreign_key: true

      t.timestamps
    end
  end
end
