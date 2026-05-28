class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.references :task_type, null: false, foreign_key: true
      t.text :board_state
      t.text :solution
      t.integer :time_limit_sec, default: 45, null: false
      t.integer :points, default: 10, null: false
      t.boolean :horror_enabled, default: false, null: false
      t.text :hint

      t.timestamps
    end
  end
end
