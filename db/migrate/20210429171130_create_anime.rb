class CreateAnime < ActiveRecord::Migration[5.2]
  def change
    create_table :anime do |t|
      t.string :name
      t.string :fav_scene
      t.integer :rating
      t.integer :user_id
      t.timestamps
    end
  end
end