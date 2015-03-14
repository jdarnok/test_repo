class Project < ActiveRecord::Base
  has_many :project_people
  has_many :users, through: :project_people
  has_many :commits
  has_many :branches
end
