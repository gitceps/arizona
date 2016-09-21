class UpdateController < ApplicationController
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
                    univ.view = 0
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
        
        redirect_to "/update_minor"
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
                    univ.view = 0
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
        redirect_to "/update_dept"
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
                university.view = 0
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
end
