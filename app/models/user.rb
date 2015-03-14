class User < ActiveRecord::Base

  has_many :project_people
  has_many :projects, through: :project_people
  has_many :commits
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include Tokenable
  has_secure_token :auth_token
end
