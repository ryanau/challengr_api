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
      t.string :state
      t.string :uid

      t.timestamps null: false  

      t.index :user_id
      t.index :uid, unique: true
    end
  end
end
