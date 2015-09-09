class PostsController < ApplicationController
  before_filter :authenticate_user!
  helper_method :category, :post, :category_posts
  respond_to :html, :json

  def new
    @post = category.posts.new(params[:post])
    respond_with @post
  end

  def edit
    respond_with(post, layout: false)
  end

  def create
    @post = Post::Creator.create(user: current_user, category: category, params: params[:post])
    respond_with category, @post do |format|
      format.html {
         render category_posts, layout: false if request.xhr?
      }
    end
  end

  def update
    post.update_attributes(params[:post])
    respond_with(post, location: category)
  end

  def destroy
    @post = post.destroy
    respond_with @post do |format|
      format.html {
        if request.xhr?
          render category_posts, layout: false
        else
          redirect_to category_path(category)
        end
      }
    end
  end

  def vote
    value = params[:type] == 'up' ? 1 : -1
    post.add_or_update_evaluation(:votes, value, current_user)
    respond_with category do |format|
      format.html {
        if request.xhr?
          # I am used to create js based Flasher for such purpose to render flash messages
          # But it is not implemented here because of lack of time 
          render category_posts, layout: false
        else
          redirect_to :back, notice: t('words.thank_you_for_voting')
        end
      }
    end
  end

  private
  def post
    @post ||= Post.find(params[:id])
  end

  def category_posts
    #this actually should be in scope, but it does not work as scope ( sorting ), and i didn't figure out why
    @posts ||= category.posts.reorder('votes desc').find_with_reputation(:votes, :all)
  end

  def category
    @category ||= Category.find(params[:category_id])
  end
end
