class ImagesController < ApplicationController

	def new
    @image = Image.new
  end

  def create
    @image = current_user.images.create(image_params)

    if @image.save
      redirect_to '/dniwe'
    else
      render 'new'
    end
  end

  def edit
    @image = Image.find(params[:id])
  end

  def update
    @image = Image.find(params[:id])
    if @image.update(image_params)
      redirect_to @image
    else
      render 'edit'
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    respond_to do |format|
      format.html { redirect_to :root}
      format.json { head :ok }
      format.js
    end
  end

  def godnota
    @image = Image.find(params[:id])
    if current_user.admin?
      @image.godno
      redirect_to :back
    end
  end

  def vote_up
    @image = Image.find(params[:id])
    Vote.record_vote(current_user, @image, 1, 'User', 'Image')
    redirect_to :back
  end

  def vote_down
    @image = Image.find(params[:id])
    Vote.record_vote(current_user, @image, -1, 'User', 'Image')
    redirect_to :back
  end

  def index
    @recent_images = Image.where(godnota: true).order('created_at DESC').all.paginate(:page => params[:page], :per_page => 3)
  end

  def show
    @image = Image.find(params[:id])

    if @image.comments.any?
      @top_comment = @image.comments.order("rating DESC, created_at ASC").first.content
    else
      @top_comment = 'Комментариев пока нет'
    end

    if params[:sort_by] == 'popular'
      @comments = @image.comments.paginate(page: params[:page], per_page: 5).order('rating DESC, created_at ASC')
    else
      @comments = @image.comments.paginate(page: params[:page], per_page: 5 ).order('created_at DESC')
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

    def image_params
      params.require(:image).permit(:image)
    end
end