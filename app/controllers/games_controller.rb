class GamesController < ApplicationController
  before_action :require_login

  def local_normal
  end

  def local_horror
  end

  def online_normal
  end

  def online_horror
  end
end