class UsersController < ApplicationController
    def index
        # debugger
        if params[:search]
            @users = User.where('username ILIKE ?', "%#{params[:search]}%")
        else
            @users = User.all
            # puts 'not working'
        end
      
        render json: @users
    end

    def create
        # user = User.new(params.permit(:name, :email))
        # user.save!
        # render json: user
        user = User.new(params.require(:user).permit(:username))
        if user.save
            render json: user
        else
            render json: user.errors.full_messages, status: :unprocessable_entity
        end
    end

    def show
        user = User.find(params[:id])
        render json: user
    end

    def update
        user = User.find(params[:id])
        if user.update!(params.permit(:username))
            render json: user
        else 
            render json: user.erros.full_messages, status: :unprocessable_entity
        end
    end

    def destroy
        user = User.find(params[:id])
        user.destroy
        redirect_to users_url
    end
end
