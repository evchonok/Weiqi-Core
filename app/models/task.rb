class Task < ApplicationRecord
  belongs_to :task_type
  has_many :user_progresses, dependent: :destroy

  validates :board_state, :solution, :task_type, presence: true
  validates :time_limit_sec, numericality: { in: 10..300 }
  validates :points, numericality: { in: 1..100 }

  # Проверка решения
  def check_solution?(user_moves)
    expected = solution.to_s.split(",").map(&:strip).map(&:upcase)
    actual = user_moves.is_a?(Array) ? user_moves.map(&:upcase) : [ user_moves.to_s.upcase ]
    expected == actual
  end
end
