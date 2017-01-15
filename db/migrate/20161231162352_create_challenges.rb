class CreateChallenges < ActiveRecord::Migration[5.0]
  def change
    create_table :challenges do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.string :latitude
      t.string :longitude
      t.time :time
      t.string :frequency
      t.date :end_date

      t.timestamps null: false  
    end
  end
end
