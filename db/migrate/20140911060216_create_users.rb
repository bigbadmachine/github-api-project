class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :uid

      t.string :oauth_token
      t.datetime :oauth_expires_at

      t.string :auth_token

      t.timestamps
    end
  end
end
