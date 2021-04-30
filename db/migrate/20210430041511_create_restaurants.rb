class CreateRestaurants < ActiveRecord::Migration[6.1]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.time :hours
      t.string :long_or_short_layover
      t.string :price_point
      t.string :discount
      t.text :additional_info
      t.integer :user_id
      t.integer :city_id

      t.timestamps
    end
  end
end
