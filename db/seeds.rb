# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or find_or_create_byd alongside the db with db:setup).
#
# Examples:
#
#   cities = City.find_or_create_by([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.find_or_create_by(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

 (1..10).each do |i|
  project = Project.find_or_create_by(name: "Simple project nr #{i}")

  (1..3).each do |i|
    branch = Branch.find_or_create_by(name: "master #{i}", project: project, user: user )

    (1..2).each do |i|
      Commit.find_or_create_by(
          name: "Simple commit #{i}",
          hash_string: Digest::SHA256.hexdigest("Simple commit #{i}"),
          user: user,
          project: project,
          branch: branch
      )
    end
  end
end


