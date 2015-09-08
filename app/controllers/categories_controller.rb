class CategoriesController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :index]

  helper_method :categories, :category, :category_posts

  respond_to :html, :json

  def index
    respond_with(categories)
  end

  def show
    respond_with(category)
  end

  def new
    respond_with(category)
  end

  def edit
  end

  def create
    category.save
    respond_with(category)
  end

  def update
    category.update_attributes(params[:category])
    respond_with(category, location: categories_path)
  end

  def destroy
    @category = category.destroy
    respond_with(@category)
  end

  def vote
    value = params[:type] == 'up' ? 1 : -1
    category.add_or_update_evaluation(:votes, value, current_user)
    respond_with category do |format|
      format.html {
        if request.xhr?
          # I am used to create js based Flasher for such purpose to render flash messages
          # But it is not implemented here because of lack of time
          render categories, layout: false
        else
          redirect_to :back, notice: t('words.thank_you_for_voting')
        end
      }
    end
  end

  private
  def categories
    #this actually should be in scope, but it does not work as scope ( sorting ), and i didn't figure out why
    @categories ||= Category.reorder('votes desc').find_with_reputation(:votes, :all)
  end

  def category
    params[:id] ? Category.find(params[:id]) : current_user.categories.new(params[:category])
  end

  def category_posts
    #this actually should be in scope, but it does not work as scope ( sorting ), and i didn't figure out why
    @posts ||= category.posts.reorder('votes desc').find_with_reputation(:votes, :all)
  end
end
