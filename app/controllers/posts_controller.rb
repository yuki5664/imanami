class PostsController < ApplicationController
  
  def index
    @posts = Post.order(created_at: :desc)
  end

  def new
    @post = Post.new # フォーム用の空のインスタンスを生成する。
  end

  def create
    @post = Post.new(post_params) # ストロングパラメータを引数に
    if @post.save # saveをしてデータベースに保存する。
        redirect_to @post, notice: '投稿が保存されました' # showページにリダイレクト
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post, notice: "投稿を更新しました。"
    else
      render :edit
    end
  end


  private

  def post_params # ストロングパラメータを定義する
    params.require(:post).permit(:area, :point, :caption, :image)
  end
end

