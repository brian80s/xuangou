class CheersController < ApplicationController
  # GET /cheers
  # GET /cheers.json
  def index
    @cheers = Cheer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cheers }
    end
  end

  # GET /cheers/1
  # GET /cheers/1.json
  def show
    @cheer = Cheer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cheer }
    end
  end

  # GET /cheers/new
  # GET /cheers/new.json
  def new
    @cheer = Cheer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cheer }
    end
  end

  # GET /cheers/1/edit
  def edit
    @cheer = Cheer.find(params[:id])
  end

  # POST /cheers
  # POST /cheers.json
  def create
    @cheer = Cheer.new(params[:cheer])

    respond_to do |format|
      if @cheer.save
        format.html { redirect_to @cheer, notice: 'Cheer was successfully created.' }
        format.json { render json: @cheer, status: :created, location: @cheer }
      else
        format.html { render action: "new" }
        format.json { render json: @cheer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cheers/1
  # PUT /cheers/1.json
  def update
    @cheer = Cheer.find(params[:id])

    respond_to do |format|
      if @cheer.update_attributes(params[:cheer])
        format.html { redirect_to @cheer, notice: 'Cheer was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @cheer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cheers/1
  # DELETE /cheers/1.json
  def destroy
    @cheer = Cheer.find(params[:id])
    @cheer.destroy

    respond_to do |format|
      format.html { redirect_to cheers_url }
      format.json { head :ok }
    end
  end
end
