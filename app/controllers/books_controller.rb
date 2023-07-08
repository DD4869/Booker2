class BooksController < ApplicationController
  def new
    raise ActiveRecord::RecordNotFound
  end

  def create
    #データを受け取り新規登録するためのインスタンス作成
    @book = Book.new(book_params)
    # ユーザーIDの紐付け
    @book.user_id = current_user.id
    if @book.save
      #各idのページにリダイレクト
      flash[:notice] = "You have created a book successfully created." #フラッシュメッセージ
      redirect_to book_path(@book.id)
    else
      @books = Book.all #render用にbooksリスト表示のため(indexアクションは呼び出されない)
      render :index
    end
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def show
  end

  def edit
  end

   private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
