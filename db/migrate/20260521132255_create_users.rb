class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :name, null: false
      t.string :password_digest, null: false
      t.boolean :horror_mode_enabled, default: false, null: false  # ← вот так!

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
