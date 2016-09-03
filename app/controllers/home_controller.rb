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
        @department = Department.all
        @ip = request.remote_ip
        @remote_ip = request.env['REMOTE_ADDR']
        
    end
    
    def search
        @univ = University.all
         @university_name = University.distinct.pluck('name');
        @univ_search = University.all
        @university_name = University.distinct.pluck('name');
        if params[:search]
            @univ_search =  University.search(params[:search]).order("created_at DESC")
        else
            @univ_search = University.all.order("created_at DESC")
        end
    end

    def input
        @every_post = Post.all
    end
    
    def point
        #TODO: 4.3 만점인 학교는 4.5로 환산 할 것
        #그런 정책을 정해야 함
        new_post = Post.new
        new_post.name = params[:univ_name]
        new_post.point = params[:point]
        new_post.save
        
        redirect_to "/list/" + new_post.id.to_s
    end
    
    def list
        @my_school = Post.where('id = ?', params[:id]).pluck('name')[0]
        @my_point = Post.where('id = ?', params[:id]).pluck('point')[0]
        
        @data_all = Post.group(:point).count
        @data_all = @data_all.to_a
        @h_axis_all = Array.new
        @data_all.each do |temp|
            @h_axis_all.push(temp.first)
        end
        @rank_all = Post.where("point > ?", @my_point).count + 1
        @all_all = Post.count
        @percent_all = (@rank_all.to_f / @all_all.to_f) * 100 
        
        @data_school = Post.where('name = ?', @my_school).group(:point).count
        @data_school = @data_school.to_a
        @h_axis_school = Array.new
        @data_school.each do |temp|
            @h_axis_school.push(temp.first)
        end
        
        @rank_school = Post.where("point > ? and name = ?", @my_point, @my_school).count + 1
        @all_school = Post.where('name = ?', @my_school).count
        @percent_school = (@rank_school.to_f / @all_school.to_f) * 100 
    end
    def update_dept
    #각 학교 별 학과를 업데이트한다.
        start_row = 2
        end_row = 18318 
        xl = Roo::Spreadsheet.open('./university_dept.xlsx')
        xl = Roo::Excelx.new("./university_dept.xlsx")
        
        xl.default_sheet = xl.sheets.first 
        
        #iterator
        start_row.upto(xl.last_row) do |row|
            department = Department.new
            department.university_id = University.distinct.where('name = ?', xl.cell(row, 'G')).pluck('id')[0]
            if department.university_id == nil
                university = University.new
                university.name = xl.cell(row, 'G')
                university.save
                department.university_id = university.id
            end
            
            department.department_name = xl.cell(row, 'K')
            #캠퍼스 구분해줘야함
            department.college = xl.cell(row, 'I')
            department.department_code = xl.cell(row, 'J')
            department.isdaytime = xl.cell(row, 'L')
            department.department_property = xl.cell(row, 'M')
            department.department_status = xl.cell(row, 'N')
            department.department_big_affiliation = xl.cell(row, 'O')
            department.department_medium_affiliation = xl.cell(row, 'P')
            department.department_small_affiliation = xl.cell(row, 'Q')
            department.course_term = xl.cell(row, 'R')
            department.degree = xl.cell(row, 'S')
            department.save
        end
        
        redirect_to "/"
    end
    
    def update
    #학교별 성적 분포를 업데이트
        start_row = 4
        end_row = 528
        xl = Roo::Spreadsheet.open('./university_major.xlsx')
        xl = Roo::Excelx.new("./university_major.xlsx")
        
        xl.default_sheet = xl.sheets.first 

        major = nil
        #iterator
        start_row.upto(xl.last_row) do |row|
            
            #1학기
            if xl.cell(row, 'G') == "1학기"
                major = DistributionMajor.new
                if University.distinct.where('name = ?', xl.cell(row, 'F')).pluck('id')[0] == nil
                    univ = University.new
                    univ.year = xl.cell(row,'A')
                    univ.is_public = xl.cell(row, 'C')
                    univ.location = xl.cell(row, 'D')
                    univ.total_students = xl.cell(row, 'H')
                    univ.is_4_5 = xl.cell(row, 'I')     
                    univ.name = xl.cell(row, 'F')
                    univ.save
                    major.university_id = univ.id
                else
                    major.university_id = University.distinct.where('name = ?', xl.cell(row, 'F')).pluck('id')[0] 
                end
                major.total_student_1 = xl.cell(row, 'H')
                major.aplus_students_1 = xl.cell(row, 'J')
                major.aplus_ratio_1 = xl.cell(row,'K')
                major.azero_students_1 = xl.cell(row, 'L')
                major.azero_ratio_1 = xl.cell(row,'M')
                major.aminus_students_1 = xl.cell(row, 'N')
                major.aminus_ratio_1 = xl.cell(row, 'O')
                major.bplus_students_1 = xl.cell(row, 'P')
                major.bplus_ratio_1 = xl.cell(row,'Q')
                major.bzero_students_1 = xl.cell(row, 'R')
                major.bzero_ratio_1 = xl.cell(row,'S')
                major.bminus_students_1 = xl.cell(row, 'T')
                major.bminus_ratio_1 = xl.cell(row, 'U')
                major.cplus_students_1 = xl.cell(row, 'V')
                major.cplus_ratio_1 = xl.cell(row,'W')
                major.czero_students_1 = xl.cell(row, 'X')
                major.czero_ratio_1 = xl.cell(row,'Y')
                major.cminus_students_1 = xl.cell(row, 'Z')
                major.cminus_ratio_1 = xl.cell(row, 'AA')
                major.dplus_students_1 = xl.cell(row, 'AB')
                major.dplus_ratio_1 = xl.cell(row,'AC')
                major.dzero_students_1 = xl.cell(row, 'AD')
                major.dzero_ratio_1 = xl.cell(row,'AE')
                major.dminus_students_1 = xl.cell(row, 'AF')
                major.dminus_ratio_1 = xl.cell(row, 'AG')
                major.f_students_1 = xl.cell(row, 'AH')
                major.f_ratio_1 = xl.cell(row, 'AI')
                
            else
            #2학기
                major.total_student_2 = xl.cell(row, 'H')
                major.aplus_students_2 = xl.cell(row, 'J')
                major.aplus_ratio_2 = xl.cell(row,'K')
                major.azero_students_2 = xl.cell(row, 'L')
                major.azero_ratio_2 = xl.cell(row,'M')
                major.aminus_students_2 = xl.cell(row, 'N')
                major.aminus_ratio_2 = xl.cell(row, 'O')
                major.bplus_students_2 = xl.cell(row, 'P')
                major.bplus_ratio_2 = xl.cell(row,'Q')
                major.bzero_students_2 = xl.cell(row, 'R')
                major.bzero_ratio_2 = xl.cell(row,'S')
                major.bminus_students_2 = xl.cell(row, 'T')
                major.bminus_ratio_2 = xl.cell(row, 'U')
                major.cplus_students_2 = xl.cell(row, 'V')
                major.cplus_ratio_2 = xl.cell(row,'W')
                major.czero_students_2 = xl.cell(row, 'X')
                major.czero_ratio_2 = xl.cell(row,'Y')
                major.cminus_students_2 = xl.cell(row, 'Z')
                major.cminus_ratio_2 = xl.cell(row, 'AA')
                major.dplus_students_2 = xl.cell(row, 'AB')
                major.dplus_ratio_2 = xl.cell(row,'AC')
                major.dzero_students_2 = xl.cell(row, 'AD')
                major.dzero_ratio_2 = xl.cell(row,'AE')
                major.dminus_students_2 = xl.cell(row, 'AF')
                major.dminus_ratio_2 = xl.cell(row, 'AG')
                major.f_students_2 = xl.cell(row, 'AH')
                major.f_ratio_2 = xl.cell(row, 'AI')
                major.save
            end
        end
        
        #학과 업데이트 하러 ㄱㄱ
        redirect_to "/search"
    end
    def update_minor
        start_row = 4
        end_row = 505
        xl = Roo::Spreadsheet.open('./university_minor.xlsx')
        xl = Roo::Excelx.new("./university_minor.xlsx")
#xl = Roo::Spreadsheet.open('./rails_temp_upload', extension: :xls)
        xl.default_sheet = xl.sheets.first 
        
        minor = nil

        #iterator
        start_row.upto(xl.last_row) do |row|
            
            #1학기
            if xl.cell(row, 'G') == "1학기"
                minor = DistributionMinor.new
                if University.distinct.where('name = ?', xl.cell(row, 'F')).pluck('id')[0] == nil
                    univ = University.new
                    univ.year = xl.cell(row,'A')
                    univ.is_public = xl.cell(row, 'C')
                    univ.location = xl.cell(row, 'D')
                    univ.is_4_5 = xl.cell(row, 'I')     
                    univ.name = xl.cell(row, 'F')
                    univ.aplus_number = xl.cell(row, 'K')
                    univ.azero_number = xl.cell(row, 'M')
                    univ.aminus_number = xl.cell(row, 'O')
                    univ.save
                    minor.university_id = univ.id
                else
                    minor.university_id = University.distinct.where('name = ?', xl.cell(row, 'F')).pluck('id')[0] 
                end
                minor.total_student_1 = xl.cell(row, 'H')
                minor.aplus_students_1 = xl.cell(row, 'J')
                minor.aplus_ratio_1 = xl.cell(row,'K')
                minor.azero_students_1 = xl.cell(row, 'L')
                minor.azero_ratio_1 = xl.cell(row,'M')
                minor.aminus_students_1 = xl.cell(row, 'N')
                minor.aminus_ratio_1 = xl.cell(row, 'O')
                minor.bplus_students_1 = xl.cell(row, 'P')
                minor.bplus_ratio_1 = xl.cell(row,'Q')
                minor.bzero_students_1 = xl.cell(row, 'R')
                minor.bzero_ratio_1 = xl.cell(row,'S')
                minor.bminus_students_1 = xl.cell(row, 'T')
                minor.bminus_ratio_1 = xl.cell(row, 'U')
                minor.cplus_students_1 = xl.cell(row, 'V')
                minor.cplus_ratio_1 = xl.cell(row,'W')
                minor.czero_students_1 = xl.cell(row, 'X')
                minor.czero_ratio_1 = xl.cell(row,'Y')
                minor.cminus_students_1 = xl.cell(row, 'Z')
                minor.cminus_ratio_1 = xl.cell(row, 'AA')
                minor.dplus_students_1 = xl.cell(row, 'AB')
                minor.dplus_ratio_1 = xl.cell(row,'AC')
                minor.dzero_students_1 = xl.cell(row, 'AD')
                minor.dzero_ratio_1 = xl.cell(row,'AE')
                minor.dminus_students_1 = xl.cell(row, 'AF')
                minor.dminus_ratio_1 = xl.cell(row, 'AG')
                minor.f_students_1 = xl.cell(row, 'AH')
                minor.f_ratio_1 = xl.cell(row, 'AI')
                
            else
            #2학기
                minor.total_student_2 = xl.cell(row, 'H')
                minor.aplus_students_2 = xl.cell(row, 'J')
                minor.aplus_ratio_2 = xl.cell(row,'K')
                minor.azero_students_2 = xl.cell(row, 'L')
                minor.azero_ratio_2 = xl.cell(row,'M')
                minor.aminus_students_2 = xl.cell(row, 'N')
                minor.aminus_ratio_2 = xl.cell(row, 'O')
                minor.bplus_students_2 = xl.cell(row, 'P')
                minor.bplus_ratio_2 = xl.cell(row,'Q')
                minor.bzero_students_2 = xl.cell(row, 'R')
                minor.bzero_ratio_2 = xl.cell(row,'S')
                minor.bminus_students_2 = xl.cell(row, 'T')
                minor.bminus_ratio_2 = xl.cell(row, 'U')
                minor.cplus_students_2 = xl.cell(row, 'V')
                minor.cplus_ratio_2 = xl.cell(row,'W')
                minor.czero_students_2 = xl.cell(row, 'X')
                minor.czero_ratio_2 = xl.cell(row,'Y')
                minor.cminus_students_2 = xl.cell(row, 'Z')
                minor.cminus_ratio_2 = xl.cell(row, 'AA')
                minor.dplus_students_2 = xl.cell(row, 'AB')
                minor.dplus_ratio_2 = xl.cell(row,'AC')
                minor.dzero_students_2 = xl.cell(row, 'AD')
                minor.dzero_ratio_2 = xl.cell(row,'AE')
                minor.dminus_students_2 = xl.cell(row, 'AF')
                minor.dminus_ratio_2 = xl.cell(row, 'AG')
                minor.f_students_2 = xl.cell(row, 'AH')
                minor.f_ratio_2 = xl.cell(row, 'AI')
                minor.save
            end
        end
        redirect_to "/search"
    end
    
    def univlist
        @university_name = params[:search]
        @university_list = University.distinct.pluck('name');
        if @university_name == "random"
            @university_name = @university_list.sample
        end
        @university_id = University.where('name = ?', @university_name).pluck('id')[0]
        
        @test = University.where('name = ?', @university_name).pluck('id');
        @test2 =  DistributionMajor.where('university_id = ?', @university_id).pluck('distinct aplus_students_2, azero_students_2, aminus_students_2, bplus_students_2, bzero_students_2, bminus_students_2, cplus_students_2, czero_students_2, cminus_students_2, dplus_students_2, dzero_students_2, dminus_students_2, f_students_2').first
        
        # 기준년도
        @year = University.distinct.pluck('year').join;
        
        # 만점평점
        @totalGradePoint = University.where('name = ?', @university_name).pluck('is_4_5').first;
        
        # 성적인정 총학생수
        @totalStudents = University.where('name = ?', @university_name).pluck('total_students').first;
        
        # A학점 비중

#        @a_total_ratio = University.where('name = ?', @university_name).pluck('aplus_number').first + University.where('name = ?', @university_name).pluck('azero_number').first + University.where('name = ?', @university_name).pluck('aminus_number').first;

        
        @aplus_top5 = DistributionMajor.joins(:university).distinct. order("aplus_ratio_1 DESC").limit(10).pluck("aplus_ratio_1, name")
        
        @aplus_bottom5 = DistributionMajor.joins(:university).distinct.order("aplus_ratio_1 ASC").limit(10).pluck("aplus_ratio_1, name")
        
        @f_top5 = DistributionMajor.joins(:university).distinct. order("f_ratio_1 DESC").limit(10).pluck("f_ratio_1, name")
        
        @f_bottom5 = DistributionMajor.joins(:university).distinct.order("f_ratio_1 ASC").limit(10).pluck("f_ratio_1, name")
        
        # 하단 배너 표시용
        @aplus_top5_list = @aplus_top5.transpose()
        
        # 하단 배너 표시 끝
        @semester = params[:semester]
        @is_major = params[:is_major]
        
        if @is_major == "true"
            @major_string = "전공"
            if @semester == "spring"
                @semester_string = "1"
                print "1학기\n"
                @query = DistributionMajor.where('university_id = ?', @university_id ).pluck('distinct aplus_students_1, aplus_ratio_1, azero_students_1, azero_ratio_1, aminus_students_1, aminus_ratio_1, bplus_students_1, bplus_ratio_1, bzero_students_1, bzero_ratio_1, bminus_students_1, bminus_ratio_1, cplus_students_1, cplus_ratio_1, czero_students_1, czero_ratio_1, cminus_students_1, cminus_ratio_1, dplus_students_1, dplus_ratio_1, dzero_students_1, dzero_ratio_1, dminus_students_1, dminus_ratio_1, f_students_1, f_ratio_1').first
            else 
                print "2학기\n"
                @semester_string = "2"
                @query = DistributionMajor.where('university_id = ?', @university_id ).pluck('distinct aplus_students_2, aplus_ratio_2, azero_students_2, azero_ratio_2, aminus_students_2, aminus_ratio_2, bplus_students_2, bplus_ratio_2, bzero_students_2, bzero_ratio_2, bminus_students_2, bminus_ratio_2, cplus_students_2, cplus_ratio_2, czero_students_2, czero_ratio_2, cminus_students_2, cminus_ratio_2, dplus_students_2, dplus_ratio_2, dzero_students_2, dzero_ratio_2, dminus_students_2, dminus_ratio_2, f_students_2, f_ratio_2').first
            end
        
            if @query.nil?
                redirect_to '/nopage'
            else
                @chart_data = Array.new

                @chart_data.insert(0, ["A+", @query[0], "A+%", @query[1]])
                @chart_data.insert(1, ["A0", @query[2], "A0%", @query[3]])
                @chart_data.insert(2, ["A-", @query[4], "A-%", @query[5]])
                @chart_data.insert(3, ["B+", @query[6], "B+%", @query[7]])
                @chart_data.insert(4, ["B0", @query[8], "B0%", @query[9]])
                @chart_data.insert(5, ["B-", @query[10], "B-%", @query[11]])
                @chart_data.insert(6, ["C+", @query[12], "C+%", @query[13]])
                @chart_data.insert(7, ["C0", @query[14], "C0%", @query[15]])
                @chart_data.insert(8, ["C-", @query[16], "C-%", @query[17]])
                @chart_data.insert(9, ["D+", @query[18], "D+%", @query[19]])
                @chart_data.insert(10, ["D0", @query[20], "D0%", @query[21]])
                @chart_data.insert(11, ["D-", @query[22], "D-%", @query[23]])
                @chart_data.insert(12, ["F", @query[24], "F%", @query[25]])
            end
        else
            @major_string = "교양"
            
            if @semester == "spring"
                print "1학기\n"
                @semester_string = "1"
                @query = DistributionMinor.where('university_id = ?', @university_id ).pluck('distinct aplus_students_1, aplus_ratio_1, azero_students_1, azero_ratio_1, aminus_students_1, aminus_ratio_1, bplus_students_1, bplus_ratio_1, bzero_students_1, bzero_ratio_1, bminus_students_1, bminus_ratio_1, cplus_students_1, cplus_ratio_1, czero_students_1, czero_ratio_1, cminus_students_1, cminus_ratio_1, dplus_students_1, dplus_ratio_1, dzero_students_1, dzero_ratio_1, dminus_students_1, dminus_ratio_1, f_students_1, f_ratio_1').first
            else 
                print "2학기\n"
                @semester_string = "2"
                @query = DistributionMinor.where('university_id = ?', @university_id ).pluck('distinct aplus_students_2, aplus_ratio_2, azero_students_2, azero_ratio_2, aminus_students_2, aminus_ratio_2, bplus_students_2, bplus_ratio_2, bzero_students_2, bzero_ratio_2, bminus_students_2, bminus_ratio_2, cplus_students_2, cplus_ratio_2, czero_students_2, czero_ratio_2, cminus_students_2, cminus_ratio_2, dplus_students_2, dplus_ratio_2, dzero_students_2, dzero_ratio_2, dminus_students_2, dminus_ratio_2, f_students_2, f_ratio_2').first
            end
        
            if @query.nil?
                redirect_to '/nopage'
            else
                @chart_data = Array.new

                @chart_data.insert(0, ["A+", @query[0], "A+%", @query[1]])
                @chart_data.insert(1, ["A0", @query[2], "A0%", @query[3]])
                @chart_data.insert(2, ["A-", @query[4], "A-%", @query[5]])
                @chart_data.insert(3, ["B+", @query[6], "B+%", @query[7]])
                @chart_data.insert(4, ["B0", @query[8], "B0%", @query[9]])
                @chart_data.insert(5, ["B-", @query[10], "B-%", @query[11]])
                @chart_data.insert(6, ["C+", @query[12], "C+%", @query[13]])
                @chart_data.insert(7, ["C0", @query[14], "C0%", @query[15]])
                @chart_data.insert(8, ["C-", @query[16], "C-%", @query[17]])
                @chart_data.insert(9, ["D+", @query[18], "D+%", @query[19]])
                @chart_data.insert(10, ["D0", @query[20], "D0%", @query[21]])
                @chart_data.insert(11, ["D-", @query[22], "D-%", @query[23]])
                @chart_data.insert(12, ["F", @query[24], "F%", @query[25]])
            end 
        end
    end
    
    def univ_add
        #교양일 경우, 2학기일 경우 case 구분
        @university_name = params[:search]
        @semester = params[:semester]
        @is_major = params[:is_major]
    
        @university_id = University.distinct.where('name = ?', @university_name).pluck('id')[0]
        
        if @is_major == "true"
            if @semester == "spring"
                print "1학기\n"
                @query = DistributionMajor.where('university_id = ?', @university_id ).pluck('distinct aplus_students_1, aplus_ratio_1, azero_students_1, azero_ratio_1, aminus_students_1, aminus_ratio_1, bplus_students_1, bplus_ratio_1, bzero_students_1, bzero_ratio_1, bminus_students_1, bminus_ratio_1, cplus_students_1, cplus_ratio_1, czero_students_1, czero_ratio_1, cminus_students_1, cminus_ratio_1, dplus_students_1, dplus_ratio_1, dzero_students_1, dzero_ratio_1, dminus_students_1, dminus_ratio_1, f_students_1, f_ratio_1').first
            else
                print "2학기\n"
                @query = DistributionMajor.where('university_id = ?', @university_id ).pluck('distinct aplus_students_2, aplus_ratio_2, azero_students_2, azero_ratio_2, aminus_students_2, aminus_ratio_2, bplus_students_2, bplus_ratio_2, bzero_students_2, bzero_ratio_2, bminus_students_2, bminus_ratio_2, cplus_students_2, cplus_ratio_2, czero_students_2, czero_ratio_2, cminus_students_2, cminus_ratio_2, dplus_students_2, dplus_ratio_2, dzero_students_2, dzero_ratio_2, dminus_students_2, dminus_ratio_2, f_students_2, f_ratio_2').first
            end
            if @query.nil?
                redirect_to '/nopage'
            else
                @chart_data = Array.new
                @chart_data = @query
            end
        else
            if @semester == "spring"
                print "1학기\n"
                @query = DistributionMinor.where('university_id = ?', @university_id ).pluck('distinct aplus_students_1, aplus_ratio_1, azero_students_1, azero_ratio_1, aminus_students_1, aminus_ratio_1, bplus_students_1, bplus_ratio_1, bzero_students_1, bzero_ratio_1, bminus_students_1, bminus_ratio_1, cplus_students_1, cplus_ratio_1, czero_students_1, czero_ratio_1, cminus_students_1, cminus_ratio_1, dplus_students_1, dplus_ratio_1, dzero_students_1, dzero_ratio_1, dminus_students_1, dminus_ratio_1, f_students_1, f_ratio_1').first
            else
                print "2학기\n"
                @query = DistributionMinor.where('university_id = ?', @university_id ).pluck('distinct aplus_students_2, aplus_ratio_2, azero_students_2, azero_ratio_2, aminus_students_2, aminus_ratio_2, bplus_students_2, bplus_ratio_2, bzero_students_2, bzero_ratio_2, bminus_students_2, bminus_ratio_2, cplus_students_2, cplus_ratio_2, czero_students_2, czero_ratio_2, cminus_students_2, cminus_ratio_2, dplus_students_2, dplus_ratio_2, dzero_students_2, dzero_ratio_2, dminus_students_2, dminus_ratio_2, f_students_2, f_ratio_2').first
            end
            if @query.nil?
                redirect_to '/nopage'
            else
                @chart_data = Array.new
                @chart_data = @query
            end
        end
        
        banana = Array.new
        banana[0] = @university_name
        banana[1] = @chart_data
        respond_to do |format|
          format.json { render json: banana.to_json}
    end
    end
    def show
        
    end
    def nopage
    
    end
end
