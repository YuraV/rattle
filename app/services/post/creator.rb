class Post::Creator
  attr_reader :user, :category, :post

  def self.create(options = {})
    new(options).create
  end

  def initialize(options = {})
    @user = options[:user]
    @category = options[:category]
    @post = Post.new(options[:params])
  end

  def create
    @post.category = category
    @post.user = user
    @post.valid? ? @post.save : false
  end
end