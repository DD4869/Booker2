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
      flash[:notice] = "You have created a book successfully." #フラッシュメッセージ
      redirect_to book_path(@book.id)
    else
      @books = Book.all #render用にbooksリスト表示のため(indexアクションは呼び出されない)
      render :index
    end
  end

  def index
    @books = Book.all
    @new_book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @new_book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])

    if @book.update(book_params)
      flash[:notice] = "You have updated a book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id]) # データ（レコード）を1件取得
    book.destroy # データ（レコード）を削除
    redirect_to books_path # 投稿一覧画面へリダイレクト
  end

   private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
