class CreateTaskLevels < ActiveRecord::Migration[8.1]
  def change
    create_table :task_levels do |t|
      t.string :name
      t.integer :difficulty, default: 1, null: false
      t.text :description

      t.timestamps
    end
  end
end
