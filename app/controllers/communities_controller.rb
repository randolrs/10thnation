class CommunitiesController < ApplicationController
  before_action :set_community, only: [:show, :edit, :update, :destroy]

  skip_before_filter :verify_authenticity_token #####****this is a workaround with POSSIBLE SECURITY GAPS####***

  # GET /communities
  # GET /communities.json
  def index
    @communities = Community.all
  end




  def community_setup 

    if user_signed_in?

      params.each do |key|

        if Community.exists?(:name => key[0])

          @community = Community.where(:name => key[0]).first

          @following = Following.new

              @following.update(:following_id => @community.id, :follower_id => current_user.id, :active => true)

              @following.save

        end

      end

      current_user.update(:onboarded => true)

      current_user.save

    end

    redirect_to root_path

  end


  # GET /communities/1
  # GET /communities/1.json
  
  def show

    @position = 0

    @top_posts = @community.hot_posts.paginate(:page => params[:page], :per_page => 20)
    
    if params[:id]
     
        @community = Community.find(params[:id])

    else

      redirect_to root_path

    end

  end


  def profile

    @position = 0
    
    if params[:url_name]

      if Community.exists?(:url_name => params[:url_name])
     
        @community = Community.where(:url_name => params[:url_name]).last

      else

        redirect_to root_path

      end

    else

      redirect_to root_path

    end

  end

  # GET /communities/new
  def new
    @community = Community.new
  end

  # GET /communities/1/edit
  def edit
  end

  # POST /communities
  # POST /communities.json
  def create
    @community = Community.new(community_params)

    respond_to do |format|
      if @community.save
        format.html { redirect_to @community, notice: 'Community was successfully created.' }
        format.json { render :show, status: :created, location: @community }
      else
        format.html { render :new }
        format.json { render json: @community.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /communities/1
  # PATCH/PUT /communities/1.json
  def update
    respond_to do |format|
      if @community.update(community_params)
        format.html { redirect_to @community, notice: 'Community was successfully updated.' }
        format.json { render :show, status: :ok, location: @community }
      else
        format.html { render :edit }
        format.json { render json: @community.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /communities/1
  # DELETE /communities/1.json
  def destroy
    @community.destroy
    respond_to do |format|
      format.html { redirect_to communities_url, notice: 'Community was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_community
      @community = Community.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def community_params
      params.require(:community).permit(:user_id, :name, :description, :approved, :parent_community_id, :image, :url_name)
    end
end
