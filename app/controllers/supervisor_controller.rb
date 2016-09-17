class SupervisorController < ApplicationController
    def delete_user
        User.delete(User.where('email = ?', params[:email]).pluck('id')[0])
        redirect_to '/'
    end
end