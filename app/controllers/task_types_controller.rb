class TaskTypesController < ApplicationController
  before_action :require_login

  def index
    @level = TaskLevel.find(params[:task_level_id])
    @task_types = @level.task_types
  end
end
