class HomeController < ApplicationController
  def index
    @products = Product.search(params[:search])
  end
  def users
    @users = User.all
  end
  def artist_profile
    @artist = User.find(params[:id])
  end
  def add_new_comment

  	commentable = Comment.get_commentable(params[:commentable_id],params[:commentable_type])
    @comment = commentable.comments.create(:title=>'cursame',:comment => params[:comment],:user_id =>current_user.id)
    @hide = params[:hide] == "true" ? true : false
    # @hide = params[:hide]
    respond_to do |format|
    	format.js
    end    
  end
  def upvote_product
    if params[:type] == 'artist'
      @artist = User.find(params[:id])
      @artist.liked_by current_user
    else
        @product = Product.find(params[:id])
        @product.liked_by current_user
    end
    respond_to do |format|
      #format.html
      format.js
    end
  end

  def downvote_product
    if params[:type] == 'artist'
      @artist = User.find(params[:id])
      @artist.downvote_from current_user
    else
      @product = Product.find(params[:id])
      @product.downvote_from current_user
    end
    respond_to do |format|
      #format.html
      format.js
    end
  end

end
