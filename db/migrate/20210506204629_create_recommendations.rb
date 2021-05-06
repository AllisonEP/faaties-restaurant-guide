class CreateRecommendations < ActiveRecord::Migration[6.1]
  def change
    create_table :recommendations do |t|
      t.string :try
      t.string :avoid
      t.integer :restaurant_id
      t.integer :user_id

      t.timestamps
    end
  end
end
