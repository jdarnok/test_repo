class AddProjectIdToBranches < ActiveRecord::Migration
  def change
    add_reference :branches, :project, index: true
    add_foreign_key :branches, :projects
  end
end
