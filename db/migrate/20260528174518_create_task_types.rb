class CreateTaskTypes < ActiveRecord::Migration[8.1]
  def change
    create_table :task_types do |t|
      t.references :task_level, null: false, foreign_key: true
      t.string :name
      t.string :icon_url
      t.text :instructions

      t.timestamps
    end
  end
end
