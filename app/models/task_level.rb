class TaskLevel < ApplicationRecord
  has_many :task_types, dependent: :destroy
  has_many :tasks, through: :task_types

  validates :name, :difficulty, presence: true
  validates :difficulty, numericality: { in: 1..10 }

  default_scope { order(:difficulty) }
end
