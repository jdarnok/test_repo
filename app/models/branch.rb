class Branch < ActiveRecord::Base
  belongs_to :user
  has_many :commits
end
