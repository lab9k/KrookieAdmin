class ShelfsController < ApplicationController
    def index
        @shelves = Shelf.all
    end

    def show
        @shelf = Shelf.find(params[:id])
    end

    def new
        @shelf = Shelf.new
    end

    def edit
        @shelf = Shelf.find(params[:id])
    end

    def create
        @shelf = Shelf.new(shelf_params)

        if @shelf.save
            redirect_to @shelf
        else
            render 'new'
        end
    end

    def update
        @shelf = Shelf.find(params[:id])

        if @shelf.update(shelf_params)
            redirect_to @shelf
        else
            render 'edit'
        end
    end

    def destroy
        @shelf = Shelf.find(params[:id])
        @shelf.destroy

        redirect_to shelfs_path
    end

    private
        def shelf_params
            params.require(:shelf).permit(:mainbeacon, :beacon1, :beacon2, :beacon3)
        end
end
