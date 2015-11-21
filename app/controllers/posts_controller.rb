class PostsController < ApplicationController

  before_action :mod_or_author_check!, only: [:edit, :update]

  def new
    @post = Post.new
    @post.sub_id = params[:sub_id]
    render :new
  end

  def create

    @post = Post.new(post_params)
    @post.author_id = current_user.id
    fail
    #@post.sub_id =

    if @post.save
      redirect_to post_url(@post)
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def edit
    render :edit
  end

  def update
    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content)
  end

  def quick_look_up
    Post.find(params[:id])
  end

  def mod_or_author_check!
    current_post = quick_look_up
    posts_owned = current_user.moderated_posts.concat(current_user.posts)
    result = posts_owned.find(current_post)
  end
end
