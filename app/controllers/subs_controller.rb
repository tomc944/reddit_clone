class SubsController < ApplicationController

  before_action :moderator_check!, only: [:edit, :update]

  def index
    render :index
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id

    if @sub.save
      redirect_to sub_url(@sub)
    else
      render :new
    end
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def edit
    render :edit
  end

  def update
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      render :edit
    end
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def quick_look_up
    Sub.find(params[:id])
  end

  def moderator_check!
    @sub = current_user.subs.find(params[:id])
  end
end
