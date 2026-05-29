class TaskType < ApplicationRecord
  belongs_to :task_level
  has_many :tasks, dependent: :destroy

  validates :name, :task_level, presence: true
end
