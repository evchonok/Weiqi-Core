class TasksController < ApplicationController
  before_action :require_login
  before_action :set_horror_mode

  def menu
    @levels = TaskLevel.order(:difficulty)
  end

  def index
    type = TaskType.find(params[:task_type_id])
    pick_next_task(type, nil)
  end

  def random
    type = TaskType.find(params[:task_type_id])
    pick_next_task(type, params[:except_id])
  end

  def show
    @task = Task.find(params[:id])
    @stones = begin
      raw = @task.board_state
      raw.present? ? JSON.parse(raw) : {}
    rescue JSON::ParserError, TypeError
      {}
    end
  end

  def attempt
    @task = Task.find(params[:id])
    user_moves = params[:moves] || []

    if @task.check_solution?(user_moves)
      progress = UserProgress.find_or_create_by(user: current_user, task: @task)
      progress.update(is_solved: true, attempts: progress.attempts + 1)
      render json: { success: true, points: @task.points, horror: false }
    else
      progress = UserProgress.find_or_create_by(user: current_user, task: @task)
      progress.increment!(:attempts)
      render json: { success: false, error: "Неверное решение", horror: @task.horror_enabled? }
    end
  end

  private

  def set_horror_mode
    @horror_mode = params[:horror] == "true"
  end

  def pick_next_task(type, exclude_id)
    # Исключаем все решённые задачи текущего пользователя
    solved_ids = UserProgress.where(user: current_user, is_solved: true).pluck(:task_id)
    exclude_ids = solved_ids + [ exclude_id.to_i ].compact

    available = type.tasks.where.not(id: exclude_ids)

    # Если всё решено, разрешаем повтор, но исключаем текущую задачу
    if available.empty?
      available = type.tasks.where.not(id: exclude_id)
      flash[:notice] = "🎉 Все задачи решены! Показываем случайную из пройденных."
    end

    task = available.sample

    if task
      redirect_to task_level_task_type_task_path(params[:task_level_id], type, task, horror: params[:horror])
    else
      redirect_to task_level_task_types_path(params[:task_level_id], horror: params[:horror]), alert: "В этом разделе пока нет задач."
    end
  end

  def parse_board_state(raw)
    return {} unless raw.present?
    JSON.parse(raw)
  rescue JSON::ParserError
    {}
  end
end
