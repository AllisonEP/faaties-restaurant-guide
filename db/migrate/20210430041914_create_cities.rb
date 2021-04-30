class CreateCities < ActiveRecord::Migration[6.1]
  def change
    create_table :cities do |t|
      t.string :name
      t.string :state_or_country
      t.string :airport_code
      t.string :hotel

      t.timestamps
    end
  end
end
