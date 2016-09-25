
require 'roo'
require 'rails4-autocomplete'

class HomeController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
     autocomplete :University, :name, :full => true

    def index
        @email = current_user.email
        @univ = University.all
        @university_name = University.distinct.pluck('name');
        @department = Department.all.distinct.pluck('university_id')
        @ip = request.remote_ip
        @remote_ip = request.env['REMOTE_ADDR']
        @univ_id = University.where('name = ?', '건국대학교').pluck('id')
        
        @department_name_test = Department.where('university_id = ?', @univ_id).pluck('department_name')
        
        @department_name = Array.new
        
    end
    
    def search
        if user_signed_in?
            if current_user.university_id == nil
                @university_name = nil
            else
                @university_name = University.distinct.where('id = ?', current_user.university_id).pluck('name')[0]
            end
        else
            @university_name = nil
        end
    
        @univ = University.all
         @university_name = University.distinct.pluck('name');
        @univ_search = University.all
        @university_list = University.distinct.pluck('name');
        
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
        #user은 임시로 생성. facebook login api와 연동해야함
        user = User.where('email = ?', current_user.email.to_s)
        if user.pluck('university_id')[0] == nil
            univ_id = University.where('name = ?', params[:univ_name]).pluck('id')[0]
            dept_id = Department.where('university_id = ? and department_name = ?', univ_id, params[:dept]).pluck('id')[0]
            
            User.where('email = ?', current_user.email.to_s).limit(1).update_all(:university_id => univ_id, :department_id => dept_id, :point => params[:point], :nickname => params[:nickname], :hakbun => params[:hakbun], :grade => [:class])
#            new_user.university_id = University.where('name = ?', params[:univ_name]).pluck('id')[0]
#            new_user.department_id = Department.where('university_id = ? and department_name = ?', new_user.university_id, params[:dept]).pluck('id')[0]
#            new_user.point = params[:point]
#            new_user.save 
        end
        
        redirect_to "/list/" + current_user.id.to_s
    end
    
    def list
        #로그인 하지 않았거나, 현재 유저와 파라미터 유저가 다르면 조회 불가처리
        if !user_signed_in?
            redirect_to '/users/sign_in'
        else 
            if current_user.id.to_s != params[:id]
                redirect_to '/'
            end
        end
        #정보 입력하지 않으면 입력하도록 리디렉션 해야함

        @users = User.all
    
        @my_point = User.where('id = ?', params[:id]).pluck('point')[0]
        @my_school_id = User.where('id = ?', params[:id]).pluck('university_id')[0]
        @my_dept_id = User.where('id = ?', params[:id]).pluck('department_id')[0]
        
        @my_school = University.where('id = ?', @my_school_id).pluck('name')[0]
        @my_dept = Department.where('id = ?', @my_dept_id).pluck('department_name')[0]
        
        #전체 데이터 계산
        #회원가입하고 데이터 입력 안한사람들을 위한 예외처리 해야함
        @data_all = User.where.not(university_id: nil).group(:point).count
        @data_all = @data_all.to_a
        @h_axis_all = Array.new
        @data_all.each do |temp|
            @h_axis_all.push(temp.first)
        end
        
        @rank_all = User.where("point > ?", @my_point).count + 1
        @all_all = User.where.not(university_id: nil).count
        @avg_all = User.where.not(university_id: nil).average(:point).round(2)
        @percent_all = ((@rank_all.to_f / @all_all.to_f) * 100).round(2)
        
        #대학교별 데이터 계산
        @data_school = User.where('university_id = ?', @my_school_id).group(:point).count
        @data_school = @data_school.to_a
        @h_axis_school = Array.new
        @data_school.each do |temp|
            @h_axis_school.push(temp.first)
        end
        
        @rank_school = User.where("point > ? and university_id = ?", @my_point, @my_school).count + 1
        @all_school = User.where('university_id = ?', @my_school_id).count
        @avg_school = User.where('university_id = ?', @my_school_id).average(:point).round(2)
        @percent_school = ((@rank_school.to_f / @all_school.to_f) * 100).round(2)
        
        #학과별 데이터 계산
        @data_dept = User.where('university_id = ? and department_id = ?',
        @my_school_id, @my_dept_id).group(:point).count
        @data_dept = @data_dept.to_a
        @h_axis_dept = Array.new
        @data_dept.each do |temp|
            @h_axis_dept.push(temp.first)
        end
        
        @rank_dept = User.where('point > ? and university_id = ? and department_id = ?', @my_point, @my_school_id, @my_dept_id).count + 1
        @all_dept = User.where('university_id = ? and department_id = ?', @my_school_id, @my_dept_id).count
        @avg_dept = User.where('university_id = ? and department_id = ?',
        @my_school_id, @my_dept_id).average(:point)
        @percent_dept = ((@rank_dept.to_f / @all_dept.to_f) * 100).round(2)
        
    end
    def univlist
        if params[:search] == nil
            @university_name = University.where('id = ?', current_user.university_id).pluck('name')[0]
        else
            @university_name = params[:search]    
        end
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
    def index_dept
        
        @university_name = params[:univ_name]
        @university_id = University.where('name = ?', @university_name).pluck('id').first
        
        @department = Department.where('university_id = ?', @university_id).pluck('department_name')
        @test = [1,2,3,4];
        respond_to do |format|
            format.json{ render json: @department.to_json}
        end
    end
    def mygrade
        if user_signed_in?
            user = User.where('email = ?', current_user.email.to_s)
            
            if user.pluck('university_id')[0] == nil
                redirect_to '/input'
            else
                redirect_to '/list/' + current_user.id.to_s
            end
            
        else
            redirect_to '/users/sign_in'
        end
    end
    def nav_univ_list
        if user_signed_in?
            if current_user.university_id == nil
                
                redirect_to '/search'
            else
                query_string = '?'
                search = University.where('id = ?', current_user.university_id).pluck('name')[0]
                puts(search)
                utf_8 = params[:utf_8]
                semester = params[:semester]
                is_major = params[:is_major]
                
                query_string += 'search=' + search + '&semester=' + semester +'&is_major='  + is_major
                
                redirect_to '/univ_list' + query_string
             
            end
            
        else
            redirect_to '/search'
        end
    end
    def nopage
    
    end
end
