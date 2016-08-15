require 'roo'
require 'rails4-autocomplete'

class HomeController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
     autocomplete :University, :name, :full => true

    def index
         @univ = University.all
         @university_name = University.distinct.pluck('name');
    end
    
    def search
        

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
        @data = Post.group(:point).count
        @data = @data.to_a
        @h_axis = Array.new
        @v_axis = Array.new
        @data.each do |temp|
            @h_axis.push(temp.first)
        end
        
        @my_point = params[:score]
        @rank = Post.where("point > ?", params[:score]).count + 1
        @all = Post.count
        @percent = (@rank.to_f / @all.to_f) * 100 
    end
    
    def update
        start_row = 4
        end_row = 528
        xl = Roo::Spreadsheet.open('./university_major.xlsx')
        xl = Roo::Excelx.new("./university_major.xlsx")
#xl = Roo::Spreadsheet.open('./rails_temp_upload', extension: :xls)
        xl.default_sheet = xl.sheets.first 
        #set hashes for label
#        headers = Hash.new
#        xl.row(1).each_with_index {|header,i|
#            headers[header] = i
#        }
        
        iseven = false
        
        univ = University.new
        #iterator
        start_row.upto(xl.last_row) do |row|
            if iseven == false
                #1학기
                univ = University.new
                univ.total_student_1 = xl.cell(row, 'H')
                univ.aplus_students_1 = xl.cell(row, 'J')
                univ.aplus_ratio_1 = xl.cell(row,'K')
                univ.azero_students_1 = xl.cell(row, 'L')
                univ.azero_ratio_1 = xl.cell(row,'M')
                univ.aminus_students_1 = xl.cell(row, 'N')
                univ.aminus_ratio_1 = xl.cell(row, 'O')
                univ.bplus_students_1 = xl.cell(row, 'P')
                univ.bplus_ratio_1 = xl.cell(row,'Q')
                univ.bzero_students_1 = xl.cell(row, 'R')
                univ.bzero_ratio_1 = xl.cell(row,'S')
                univ.bminus_students_1 = xl.cell(row, 'T')
                univ.bminus_ratio_1 = xl.cell(row, 'U')
                univ.cplus_students_1 = xl.cell(row, 'V')
                univ.cplus_ratio_1 = xl.cell(row,'W')
                univ.czero_students_1 = xl.cell(row, 'X')
                univ.czero_ratio_1 = xl.cell(row,'Y')
                univ.cminus_students_1 = xl.cell(row, 'Z')
                univ.cminus_ratio_1 = xl.cell(row, 'AA')
                univ.dplus_students_1 = xl.cell(row, 'AB')
                univ.dplus_ratio_1 = xl.cell(row,'AC')
                univ.dzero_students_1 = xl.cell(row, 'AD')
                univ.dzero_ratio_1 = xl.cell(row,'AE')
                univ.dminus_students_1 = xl.cell(row, 'AF')
                univ.dminus_ratio_1 = xl.cell(row, 'AG')
                univ.f_students_1 = xl.cell(row, 'AH')
                univ.f_ratio_1 = xl.cell(row, 'AI')
                
                iseven = true
            else 
                #2학기
                univ.total_student_2 = xl.cell(row, 'H')
                univ.aplus_students_2 = xl.cell(row, 'J')
                univ.aplus_ratio_2 = xl.cell(row,'K')
                univ.azero_students_2 = xl.cell(row, 'L')
                univ.azero_ratio_2 = xl.cell(row,'M')
                univ.aminus_students_2 = xl.cell(row, 'N')
                univ.aminus_ratio_2 = xl.cell(row, 'O')
                univ.bplus_students_2 = xl.cell(row, 'P')
                univ.bplus_ratio_2 = xl.cell(row,'Q')
                univ.bzero_students_2 = xl.cell(row, 'R')
                univ.bzero_ratio_2 = xl.cell(row,'S')
                univ.bminus_students_2 = xl.cell(row, 'T')
                univ.bminus_ratio_2 = xl.cell(row, 'U')
                univ.cplus_students_2 = xl.cell(row, 'V')
                univ.cplus_ratio_2 = xl.cell(row,'W')
                univ.czero_students_2 = xl.cell(row, 'X')
                univ.czero_ratio_2 = xl.cell(row,'Y')
                univ.cminus_students_2 = xl.cell(row, 'Z')
                univ.cminus_ratio_2 = xl.cell(row, 'AA')
                univ.dplus_students_2 = xl.cell(row, 'AB')
                univ.dplus_ratio_2 = xl.cell(row,'AC')
                univ.dzero_students_2 = xl.cell(row, 'AD')
                univ.dzero_ratio_2 = xl.cell(row,'AE')
                univ.dminus_students_2 = xl.cell(row, 'AF')
                univ.dminus_ratio_2 = xl.cell(row, 'AG')
                univ.f_students_2 = xl.cell(row, 'AH')
                univ.f_ratio_2 = xl.cell(row, 'AI')
                
                iseven = false
            end
            #write some codes
            #univ = University.new
            univ.is_public = xl.cell(row, 'C')
            univ.location = xl.cell(row, 'D')
            
            univ.is_4_5 = xl.cell(row, 'I')     
            univ.name = xl.cell(row, 'F')
            univ.save
        end
        
        redirect_to "/univ_list"
    end
    
    def univlist
        
        @univ = University.all
        @university_name = params[:search]
        @query = University.where('name = ?', @university_name ).pluck('distinct aplus_students_1, azero_students_1, aminus_students_1, bplus_students_1, bzero_students_1, bminus_students_1, cplus_students_1, czero_students_1, cminus_students_1, dplus_students_1, dzero_students_1, dminus_students_1, f_students_1').first
        
        @chart_data = Array.new
        
        @chart_data.insert(0, ["A+", @query[0]])
        @chart_data.insert(1, ["A0", @query[1]])
        @chart_data.insert(2, ["A-", @query[2]])
        @chart_data.insert(3, ["B+", @query[3]])
        @chart_data.insert(4, ["B0", @query[4]])
        @chart_data.insert(5, ["B-", @query[5]])
        @chart_data.insert(6, ["C+", @query[6]])
        @chart_data.insert(7, ["C0", @query[7]])
        @chart_data.insert(8, ["C-", @query[8]])
        @chart_data.insert(9, ["D+", @query[9]])
        @chart_data.insert(10, ["D0", @query[10]])
        @chart_data.insert(11, ["D-", @query[11]])
        @chart_data.insert(12, ["F", @query[12]])
        
        @univ_search = University.all
    if params[:search]
        @univ_search =  University.search(params[:search]).order("created_at DESC")
    else
        @univ_search = University.all.order("created_at DESC")
    end
        
    end

end
