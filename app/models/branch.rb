class Branch < ActiveRecord::Base
  belongs_to :user
  has_many :commits
  belongs_to :project
end
