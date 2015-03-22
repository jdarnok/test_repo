class Api::V2::CommitsController < ApplicationController

  respond_to :json
  before_action :doorkeeper_authorize!
  before_action :set_commit, only: [:show, :destroy]

  def index

    respond_with(:commits => current_resource_owner.commits ? Commit.all : [])
  end

  def show
    respond_with(:commit => @respond ? @respond : [])

  end

  def destroy
    if @respond
      @respond.destroy
      render json: {}, status: 200
    else

      render json: {error: "Commit could not be deleted."}, status: 422

    end
  end

  private

    def set_commit
      @respond = Commit.find_by(id: params[:id])
    end

  def current_resource_owner
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

end
