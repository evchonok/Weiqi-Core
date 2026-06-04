class Task < ApplicationRecord
  belongs_to :task_type
  has_many :user_progresses, dependent: :destroy

  validates :board_state, :solution, :task_type, presence: true
  validates :time_limit_sec, numericality: { in: 10..300 }
  validates :points, numericality: { in: 1..100 }

  # Проверка решения
  def check_solution?(user_moves)
    return false if user_moves.blank? || solution.blank?

    # Превращаем решение из БД в массив
    expected = solution.to_s.upcase.split(",").map(&:strip)

    # Приводим ввод пользователя к тому же формату
    actual = if user_moves.is_a?(String)
               user_moves.upcase.split(",").map(&:strip)
    else
               user_moves.map(&:to_s).map(&:upcase).map(&:strip)
    end
    expected == actual
  end
end
