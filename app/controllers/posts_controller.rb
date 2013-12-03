class PostsController < ApplicationController

  def show
    @topic = Topic.find(params[:topic_id])
    authorize! :read, @topic, message: "You need to be signed-in to do that."
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = Comment.new
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
    authorize! :create, Post, message: "You need to be a member to create a new post."
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize! :edit, @post, message: "You need to own the post to edit it."
  end  

  def create
    @topic = Topic.find(params[:topic_id])
    @post = current_user.posts.build(params[:post])
    @post.topic = @topic

    authorize! :create, @post, message: "You need to be signed up to do that."
    if @post.save
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize! :update, @post, message: "You need to own the post to edit it."
    if @post.update_attributes(params[:post])
      flash[:notice] = "Post was updated."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])

    title = @post.title
    authorize! :destroy, @post, message: "You need to own the post to delete it."
    if @post.destroy
      flash[:notice] = "\"#{title}\" was deleted successfully."
      redirect_to @topic
    else
      flash[:error] = "There was an error deleting the post."
      render :show
    end
  end  

end