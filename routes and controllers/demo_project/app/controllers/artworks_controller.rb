class ArtworksController < ApplicationController
    def index
        if params[:user_id]
            artwork = Artwork.artworks_for_user_id(params[:user_id])
            render json: artwork
        end
    end

    def create
        artwork = Artwork.new(params.require(:artwork).permit(:title, :image_url, :artist_id))
        if artwork.save
            render json: artwork
        else
            render json: artwork.errors.full_messages, status: :unprocessable_entity
        end
    end

    def show
        artwork = Artwork.find(params[:id])
        render json: artwork
    end

    def update
        artwork = Artwork.find(params[:id])
        if artwork.update!(params.permit(:title, :image_url, :artist_id))
            render json: artwork
        else 
            render json: artwork.erros.full_messages, status: :unprocessable_entity
        end
    end

    def destroy
        artwork = Artwork.find(params[:id])
        artwork.destroy
        redirect_to artworks_url
    end
end
