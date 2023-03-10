class ArtworkSharesController < ApplicationController
    def create
        artworkshare = ArtworkShare.new(params.require(:artwork_shares).permit(:artwork_id, :viewer_id))
        if artworkshare.save
            render json: artworkshare
        else
            render json: artworkshare.errors.full_messages, status: :unprocessable_entity
        end
    end

    def destroy
        artworkshare = ArtworkShare.find(params[:id])
        artworkshare.destroy
        render json: artworkshare
    end
end
