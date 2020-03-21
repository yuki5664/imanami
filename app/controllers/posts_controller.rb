class PostsController < ApplicationController
  before_action :authenticate_user!, except: [ :index]
  before_action :set_post, only: [ :show, :edit, :update, :destroy]

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result.find_newest_post(params[:page])
  end

  def new
    @post = Post.new # フォーム用の空のインスタンスを生成する。
  end

  def create
    @post = current_user.posts.new(post_params) # ストロングパラメータを引数に
    if @post.save # saveをしてデータベースに保存する。
        redirect_to @post, notice: '投稿が保存されました' # showページにリダイレクト
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "投稿を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "投稿を削除しました。"
  end


  private

  def post_params # ストロングパラメータを定義する
    params.require(:post).permit(:area, :point, :caption, :image)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end

