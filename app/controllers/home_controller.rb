require 'roo'
xl = Roo::Spreadsheet.open('./university.xlsx')
xl = Roo::Excelx.new("./university.xlsx")
#xl = Roo::Spreadsheet.open('./rails_temp_upload', extension: :xls)
xl.default_sheet = xl.sheets.first

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
        @hi = Post.group(:point).count
    end
    
    def update
        #set hashes for label
#        headers = Hash.new
#        xl.row(1).each_with_index {|header,i|
#            headers[header] = i
#        }
        
        univ = University.new
        #iterator
        ((xl.first_row + 1)..xl.last_row).each do |row|
            #write some codes
            univ.location = xl.cell(row, 'D')
            univ.name = xl.cell(row, 'F')
            univ.save
        end
        
        redirect_to "/univ_list"

    end
    
    def univlist
        @univ = University.new
        
    end
    
end
