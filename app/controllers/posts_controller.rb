class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    
    @comment = Comment.new
    @commentable = true
    @response = Comment.new
    
    if @post.body.length > 0
      @show_post_details = true
    end

  end

  def up_vote

    if user_signed_in?

      if params[:post_id]

        if Post.exists?(params[:post_id])

          if PostVote.exists?(:user_id => current_user.id, :post_id => params[:post_id])

            @existing_post_vote =  PostVote.where(:user_id => current_user.id, :post_id => params[:post_id]).last

            if @existing_post_vote.is_up

              @existing_post_vote.update(:is_up => false, :is_down => false)

              if @existing_post_vote.save

                render json: { :change => -1, :notice=> notice, content_type: 'text/json' }
            
              else
                
                render json: { :change => 0, :notice=> notice, content_type: 'text/json' }
             
              end

            elsif @existing_post_vote.is_down

              @existing_post_vote.update(:is_up => true, :is_down => false)

              if @existing_post_vote.save

                render json: { :change => 2, :notice=> notice, content_type: 'text/json' }
            
              else
                
                render json: { :change => 0, :notice=> notice, content_type: 'text/json' }
             
              end

            else

              @existing_post_vote.update(:is_up => true, :is_down => false)

              if @existing_post_vote.save

                render json: { :change => 1, :notice=> notice, content_type: 'text/json' }
            
              else
                
                render json: { :change => 0, :notice=> notice, content_type: 'text/json' }
             
              end



            end

          else

            @post_vote = PostVote.new

            @post_vote.update(:user_id => current_user.id, :post_id => params[:post_id], :is_up => true, :is_down => false)

            if @post_vote.save

              render json: { :change => 1, :notice=> notice, content_type: 'text/json' }
          
            else
              
              render json: { :change => 0, :notice=> notice, content_type: 'text/json' }
           
            end

          end

        end

      end

    end


  end



  def down_vote

    if user_signed_in?

      if params[:post_id]

        if Post.exists?(params[:post_id])

          if PostVote.exists?(:user_id => current_user.id, :post_id => params[:post_id])

            @existing_post_vote =  PostVote.where(:user_id => current_user.id, :post_id => params[:post_id]).last

            if @existing_post_vote.is_down

              @existing_post_vote.update(:is_up => false, :is_down => false)

              if @existing_post_vote.save

                render json: { :change => 1, :notice=> notice, content_type: 'text/json' }
            
              else
                
                render json: { :change => 0, :notice=> notice, content_type: 'text/json' }
             
              end

            elsif @existing_post_vote.is_up

              @existing_post_vote.update(:is_up => false, :is_down => true)

              if @existing_post_vote.save

                render json: { :change => -2, :notice=> notice, content_type: 'text/json' }
            
              else
                
                render json: { :change => 0, :notice=> notice, content_type: 'text/json' }
             
              end

            else

              @existing_post_vote.update(:is_up => false, :is_down => true)

              if @existing_post_vote.save

                render json: { :change => -1, :notice=> notice, content_type: 'text/json' }
            
              else
                
                render json: { :change => 0, :notice=> notice, content_type: 'text/json' }
             
              end

            end
            
          else

            @post_vote = PostVote.new

            @post_vote.update(:user_id => current_user.id, :post_id => params[:post_id], :is_up => false, :is_down => true)

            if @post_vote.save

              render json: { :change => -1, :notice=> notice, content_type: 'text/json' }
          
            else
              
              render json: { :change => 0, :notice=> notice, content_type: 'text/json' }
           
            end

          end

        end

      end

    end


  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    if user_signed_in?
      
      unless @post.user_id
        @post.update(:user_id => current_user.id)
      end
      
    else

      redirect_to new_user_session_path

    end

    respond_to do |format|
      if @post.save
        
        @post_vote = PostVote.new

        @post_vote.update(:user_id => current_user.id, :post_id => @post.id, :is_up => true, :is_down => false)

        @post_vote.save 

        format.html { redirect_to root_path, notice: 'Post was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:user_id, :title, :body, :url, :image, :community_id)
    end
end
