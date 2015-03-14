class Api::V1::ProjectController < ApiController
  def index
    @projects = Project.all
  end
end
