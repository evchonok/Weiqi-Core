class CreateUserProgresses < ActiveRecord::Migration[8.1]
  def change
    create_table :user_progresses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :task, null: false, foreign_key: true
      t.boolean :is_solved, default: false, null: false
      t.integer :attempts, default: 0, null: false
      t.integer :time_spent_sec, default: 0, null: false

      t.timestamps
    end
  end
end
