class TasksController < ApplicationController
  before_action :require_login
  before_action :set_horror_mode

  # === PUBLIC ACTIONS (должны быть ДО private) ===
  def menu
    @levels = TaskLevel.order(:difficulty)
  end

  def index
    @type = TaskType.find(params[:task_type_id])
    @tasks = @type.tasks
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

  # === PRIVATE METHODS (только вспомогательные) ===
  private

  def set_horror_mode
    @horror_mode = params[:horror] == "true"
  end

  def parse_board_state(raw)
    return {} unless raw.present?
    JSON.parse(raw)
  rescue JSON::ParserError
    {}
  end
end
