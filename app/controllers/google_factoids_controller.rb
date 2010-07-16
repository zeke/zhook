class GoogleFactoidsController < ApplicationController
  # GET /google_factoids
  # GET /google_factoids.xml
  def index
    @google_factoids = GoogleFactoid.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @google_factoids }
    end
  end

  # GET /google_factoids/1
  # GET /google_factoids/1.xml
  def show
    @google_factoid = GoogleFactoid.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @google_factoid }
    end
  end

  # GET /google_factoids/new
  # GET /google_factoids/new.xml
  def new
    @google_factoid = GoogleFactoid.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @google_factoid }
    end
  end

  # GET /google_factoids/1/edit
  def edit
    @google_factoid = GoogleFactoid.find(params[:id])
  end

  # POST /google_factoids
  # POST /google_factoids.xml
  def create
    @google_factoid = GoogleFactoid.new(params[:google_factoid])

    respond_to do |format|
      if @google_factoid.save
        flash[:notice] = 'GoogleFactoid was successfully created.'
        format.html { redirect_to(@google_factoid) }
        format.xml  { render :xml => @google_factoid, :status => :created, :location => @google_factoid }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @google_factoid.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /google_factoids/1
  # PUT /google_factoids/1.xml
  def update
    @google_factoid = GoogleFactoid.find(params[:id])

    respond_to do |format|
      if @google_factoid.update_attributes(params[:google_factoid])
        flash[:notice] = 'GoogleFactoid was successfully updated.'
        format.html { redirect_to(@google_factoid) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @google_factoid.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /google_factoids/1
  # DELETE /google_factoids/1.xml
  def destroy
    @google_factoid = GoogleFactoid.find(params[:id])
    @google_factoid.destroy

    respond_to do |format|
      format.html { redirect_to(google_factoids_url) }
      format.xml  { head :ok }
    end
  end
end
