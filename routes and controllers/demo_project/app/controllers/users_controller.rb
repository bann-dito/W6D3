class UsersController < ApplicationController
    def index
        # users = User.all
        # render json: users
        render json: User.all
        # render plain: "I'm in the index action!"
    end

    def create
        # user = User.new(params.permit(:name, :email))
        # user.save!
        # render json: user
        user = User.new(params.require(:user).permit(:name, :email))
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
        user.update!(params.permit(:name, :email))
        redirect_to index
    end

    def destroy
        user = User.find(params[:id])
        user.destroy
        redirect_to index
    end
end
