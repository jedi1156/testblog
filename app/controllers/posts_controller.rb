class PostsController < ApplicationController
  before_filter :authenticate_user!

  expose_decorated(:posts)
  expose_decorated(:post)
  expose_decorated(:comments) { post.comments }

  def index
  end

  def new
  end

  def edit
    unless current_user.owner? post
      flash[:error] = "Not your post"
      redirect_to action: :show
    end
  end

  def update
    if current_user.owner? post
      if post.save
        render action: :index
      else
        render :new
      end
    else
      render action: :index, flash: { error: "Not yours to touch" }
    end
  end

  def destroy
    if current_user.owner? post
      post.destroy 
      render action: :index, flash: { notice: "Got rid of that pesky thing, sire" }
    else
      render action: :index, flash: { error: "Not yours to touch" }
    end
  end

  def show
  end

  def mark_archived
    post.archive!
    render action: :index
  end

  def create
    post.user_id = current_user.id
    if post.save
      redirect_to action: :index
    else
      render :new
    end
  end

end
