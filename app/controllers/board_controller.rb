class BoardController < ApplicationController
  @@item_per_page = 5
  def list
      @posts = Post.all.order("created_at DESC")
      @post_count = @posts.count
      @page_count = (@post_count.to_f / 1.to_f).ceil
      
      @pages = Post.paginate(:page => params[:page], :per_page => @@item_per_page).order('id DESC')
      
  end
  def view_post
      #@posts = Post.find_by_sql("SELECT * FROM posts order by posts.id desc")
      @posts = Post.all.order("created_at DESC")
      
      @post_count = @posts.count
      @page_count = (@post_count.to_f / 1.to_f).ceil
      
      @pages = Post.paginate(:page => params[:page], :per_page =>@@item_per_page).order('id DESC')
      
      @p = @posts.find(params[:id])
      @date = @p.created_at.strftime("%Y-%m-%d %H:%M")
      @p.view += 1
      @p.save
      @replies = Reply.all
  end
  def upvote_post
      #중복 추천 불가하게 해야함
      @p = @posts.find(pararms[:id])
      @p.like += 1
      @p.save
  end
  def downvote_post
      #중복 추천 불가하게 해야함
      @p = @posts.find(pararms[:id])
      @p.like -= 1
      @p.save
  end
  def upvote_reply
      
  end
  def downvote_reply
      
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
    #AJAX call
    reply = Reply.new
    reply.content = params[:reply_content]
    reply.post_id = params[:id_of_post]
    reply.like = 0
    reply.dislike = 0
    reply.save

    redirect_to "/board/view_post/" + params[:id_of_post].to_s
  end
end
