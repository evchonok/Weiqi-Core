# app/controllers/task_types_controller.rb
class TaskTypesController < ApplicationController
  before_action :require_login

  def index
    # Находим уровень по ID из URL
    @level = TaskLevel.find(params[:task_level_id])
    # Получаем все типы задач этого уровня
    @types = @level.task_types
  end
end
