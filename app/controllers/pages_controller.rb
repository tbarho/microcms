class PagesController < ApplicationController
  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.find(:all, :conditions => ['parent_id IS NULL'], :order => :position)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    @page = Page.find_by_name(params[:id])
    @page ||= Page.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/new
  # GET /pages/new.json
  def new
    @page = Page.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render json: @page, status: :created, location: @page }
      else
        format.html { render action: "new" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.json
  def update
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :ok }
    end
  end

  # PUT /pages/1;higher
  def higher
    page = Page.find(params[:id])
    unless page.nil?
      if page.first?
        page.move_to_bottom
      else
        page.move_higher
      end
    end
    redirect_to pages_url
  end

  # PUT /pages/1;lower
  def lower
    page = Page.find(params[:id])
    unless page.nil?
      if page.last?
        page.move_to_top
      else    
        page.move_lower
      end
    end
    redirect_to pages_url 
  end

  def mercury_update
    page = Page.find(params[:id])
    page.title = params[:content][:page_name][:value]
    page.body = params[:content][:page_content][:value]
    page.save!
    render text: ""
  end
end
