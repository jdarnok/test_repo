class CreateProjectPeople < ActiveRecord::Migration
  def change
    create_table :project_people do |t|
      t.references :project, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :project_people, :projects
    add_foreign_key :project_people, :users
  end
end
