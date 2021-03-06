class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  def up_vote

    if user_signed_in?

      if params[:comment_id]

        if Comment.exists?(params[:comment_id])

          if CommentVote.exists?(:user_id => current_user.id, :comment_id => params[:comment_id])

            @existing_comment_vote =  CommentVote.where(:user_id => current_user.id, :comment_id => params[:comment_id]).last

            if @existing_comment_vote.is_up

              @existing_comment_vote.update(:is_up => false, :is_down => false)

              if @existing_comment_vote.save

                render json: { :change => -1, :notice=> notice, content_type: 'text/json' }
            
              else
                
                render json: { :change => 0, :notice=> notice, content_type: 'text/json' }
             
              end

            elsif @existing_comment_vote.is_down

              @existing_comment_vote.update(:is_up => true, :is_down => false)

              if @existing_comment_vote.save

                render json: { :change => 2, :notice=> notice, content_type: 'text/json' }
            
              else
                
                render json: { :change => 0, :notice=> notice, content_type: 'text/json' }
             
              end

            else

              @existing_comment_vote.update(:is_up => true, :is_down => false)

              if @existing_comment_vote.save

                render json: { :change => 1, :notice=> notice, content_type: 'text/json' }
            
              else
                
                render json: { :change => 0, :notice=> notice, content_type: 'text/json' }
             
              end

            end


          else

            @comment_vote = CommentVote.new

            @comment_vote.update(:user_id => current_user.id, :comment_id => params[:comment_id], :is_up => true, :is_down => false)

            if @comment_vote.save

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

      if params[:comment_id]

        if Comment.exists?(params[:comment_id])

          if CommentVote.exists?(:user_id => current_user.id, :comment_id => params[:comment_id])

            @existing_comment_vote =  CommentVote.where(:user_id => current_user.id, :comment_id => params[:comment_id]).last

            if @existing_comment_vote.is_down

              @existing_comment_vote.update(:is_up => false, :is_down => false)

              if @existing_comment_vote.save

                render json: { :change => 1, :notice=> notice, content_type: 'text/json' }
            
              else
                
                render json: { :change => 0, :notice=> notice, content_type: 'text/json' }
             
              end

            elsif @existing_comment_vote.is_up

              @existing_comment_vote.update(:is_up => false, :is_down => true)

              if @existing_comment_vote.save

                render json: { :change => -2, :notice=> notice, content_type: 'text/json' }
            
              else
                
                render json: { :change => 0, :notice=> notice, content_type: 'text/json' }
             
              end

            else

              @existing_comment_vote.update(:is_up => false, :is_down => true)

              if @existing_comment_vote.save

                render json: { :change => -1, :notice=> notice, content_type: 'text/json' }
            
              else
                
                render json: { :change => 0, :notice=> notice, content_type: 'text/json' }
             
              end

            end

          else

            @comment_vote = CommentVote.new

            @comment_vote.update(:user_id => current_user.id, :comment_id => params[:comment_id], :is_up => false, :is_down => true)

            if @comment_vote.save

              render json: { :change => -1, :notice=> notice, content_type: 'text/json' }
          
            else
              
              render json: { :change => 0, :notice=> notice, content_type: 'text/json' }
           
            end

          end

        end

      end

    end


  end


  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)

    if user_signed_in?
      
      unless @comment.user_id
        @comment.update(:user_id => current_user.id)
      end

    else

      redirect_to root_path

    end

    respond_to do |format|
      if @comment.save
        format.html { redirect_to :back, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { redirect_to root_path}
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:post_id, :user_id, :comment_text, :parent_comment_id, :score)
    end
end
