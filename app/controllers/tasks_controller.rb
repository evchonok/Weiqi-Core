# app/controllers/tasks_controller.rb
class TasksController < ApplicationController
  before_action :require_login

  def menu
    @levels = TaskLevel.order(:difficulty)
  end

  def index
    @type = TaskType.find(params[:task_type_id])
    @tasks = @type.tasks
  end

  def show
    @task = Task.find(params[:id])
    @initial_stones = parse_board_state(@task.board_state)
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

  def parse_board_state(raw)
    return {} unless raw.present?
    JSON.parse(raw)
  rescue JSON::ParserError
    {}
  end
end