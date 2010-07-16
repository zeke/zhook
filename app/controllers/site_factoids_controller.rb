class SiteFactoidsController < ApplicationController
  # GET /site_factoids
  # GET /site_factoids.xml
  def index
    @site_factoids = SiteFactoid.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @site_factoids }
    end
  end

  # GET /site_factoids/1
  # GET /site_factoids/1.xml
  def show
    @site_factoid = SiteFactoid.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @site_factoid }
    end
  end

  # GET /site_factoids/new
  # GET /site_factoids/new.xml
  def new
    @site_factoid = SiteFactoid.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @site_factoid }
    end
  end

  # GET /site_factoids/1/edit
  def edit
    @site_factoid = SiteFactoid.find(params[:id])
  end

  # POST /site_factoids
  # POST /site_factoids.xml
  def create
    @site_factoid = SiteFactoid.new(params[:site_factoid])

    respond_to do |format|
      if @site_factoid.save
        flash[:notice] = 'SiteFactoid was successfully created.'
        format.html { redirect_to(@site_factoid) }
        format.xml  { render :xml => @site_factoid, :status => :created, :location => @site_factoid }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @site_factoid.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /site_factoids/1
  # PUT /site_factoids/1.xml
  def update
    @site_factoid = SiteFactoid.find(params[:id])

    respond_to do |format|
      if @site_factoid.update_attributes(params[:site_factoid])
        flash[:notice] = 'SiteFactoid was successfully updated.'
        format.html { redirect_to(@site_factoid) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @site_factoid.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /site_factoids/1
  # DELETE /site_factoids/1.xml
  def destroy
    @site_factoid = SiteFactoid.find(params[:id])
    @site_factoid.destroy

    respond_to do |format|
      format.html { redirect_to(site_factoids_url) }
      format.xml  { head :ok }
    end
  end
end
