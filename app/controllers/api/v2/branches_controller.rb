class Api::V2::BranchesController < ApplicationController
  respond_to :json
  before_action :set_branch, only: [:show, :destroy, :update]
  before_action :doorkeeper_authorize!

def index
    @branches = Branch.all
    render json: @branches
  end

  def show
    @branch = Branch.find(params[:id])
    render json: @branch
  end

  #PUT
  def update
    if @branch.update(branch_params)
      render json: @branch
    end
  end

  #POST
  def create
    @branch = Branch.new(branch_params)
    render json: @branch, status:200
  end

  #DELETE
  def destroy
    @branch = Branch.find(params[:id])
    @branch.commits.delete_all
    @branch.destroy
    render json: 'branch anihilated!', status: 200
  end
  private

  def set_branch
    @branch = Branch.find_by(id: params[:id])
  end
    def branch_params
      params.require(:branch).permit(:name)
    end
end
