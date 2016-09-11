class BoardController < ApplicationController
  def list
      @posts = Post.all.order("created_at DESC")
  end
  def view_post
      @posts = Post.all
      @p = @posts.find(params[:id])
      @p.view += 1
      @p.save
      @replies = Reply.all
  end
  def new_post
      
  end
  def upload_post
    post = Post.new
    post.title = params[:title]
    post.content = params[:content]
    post.view = 0
    post.like = 0
    post.dislike = 0
      if post.save
        redirect_to "/board"
      else
        render :text => post.errors.messages
      end
  end
  def reply_write
    reply = Reply.new
    reply.content = params[:reply_content]
    reply.post_id = params[:id_of_post]
    reply.like = 0
    reply.dislike = 0
    reply.save
    #AJAX call
    redirect_to "/board/view_post/" + params[:id_of_post].to_s
  end
end
