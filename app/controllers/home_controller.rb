class HomeController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
    def index
        
    end
    def regular
    end
    
    def input
        @every_post = Post.all
    end
    
    def point
        
        new_post = Post.new
        new_post.point = params[:point]
        new_post.save
        
        
        redirect_to "/list/" + params[:point]
        
    end
    
    def list
        @my_point = params[:score]
        @rank = Post.where("point > ?", params[:score]).count + 1
        @all = Post.count
        @percent = (@rank.to_f / @all.to_f) * 100
        
    end
    
end
