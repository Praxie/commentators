class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @image = Image.find(params[:image_id])
    @comment = current_user.comments.create(comment_params)
    redirect_to @image
  end

  def destroy
    @image = Image.find(params[:image_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to :back
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :image_id)
    end
end