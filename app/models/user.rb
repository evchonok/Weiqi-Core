class User < ApplicationRecord
  has_secure_password  # добавляет методы password= и authenticate

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
  validates :name, presence: true, length: { minimum: 2, maximum: 50 }

  has_many :user_progresses, dependent: :destroy
  has_many :solved_tasks, through: :user_progresses, source: :task
end
