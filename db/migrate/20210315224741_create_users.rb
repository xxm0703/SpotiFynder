class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.text :username
      t.text :password_hash
      t.text :password_salt
      t.text :spotify_id

      t.timestamps
    end
  end
end
