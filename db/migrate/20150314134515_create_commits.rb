class CreateCommits < ActiveRecord::Migration
  def change
    create_table :commits do |t|
      t.string :name
      t.string :hash_string
      t.references :user, index: true
      t.references :project, index: true
      t.references :branch, index: true

      t.timestamps null: false
    end
    add_foreign_key :commits, :users
    add_foreign_key :commits, :projects
    add_foreign_key :commits, :branches
  end
end
