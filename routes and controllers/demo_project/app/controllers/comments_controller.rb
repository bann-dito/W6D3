class CommentsController < ApplicationController
    def index
        if params[:user_id]
            comment = Comment.comments_for_author_id(params[:user_id])
            render json: comment
        elsif params[:artwork_id]
            comment = Comment.comments_for_artwork_id(params[:artwork_id])
            render json: comment
        end
    end

    def create
        comment = Comment.new(params.require(:comment).permit(:body, :author_id, :artwork_id))
        if comment.save
            render json: comment
        else
            render json: user.errors.full_messages, status: :unprocessable_entity
        end
    end

    def destroy
        comment = Comment.find(params[:id])
        comment.destroy
        render json: comment
    end
end
