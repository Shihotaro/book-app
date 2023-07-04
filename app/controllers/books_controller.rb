class BooksController < ApplicationController
  before_action :set_book, only:[:show, :edit, :update, :destroy]
  before_action :redirect_to_signin
  
  def index
      @books = Book.where(user_id: session[:user_id])
      @books = @books.where(year: params[:year]) if params[:year].present?
      @books = @books.where(month: params[:month]) if params[:month].present?
  end

  def show
      # paramsは、引数で指定した値をURLから持ってくる
      # @book = Book.find(params[:id])
  end

  def new
      # 空のクラスを用意
      @book = Book.new
  end

  def create
      # URLのbookからpermit()内の要素を代入
      book_params = params.require(:book).permit(:year, :month, :inout, :category, :amount)
      book_params[:user_id] = session[user_id]
      # 空のクラスにbook_paramsを挿入し、代入
      @book = Book.new(book_params)
      # データの保存
      if @book.save
        redirect_to books_path
      else
        render :new
      end
  end

  def edit
    # @book = Book.find(params[:id])
  end

  def update
    # @book = Book.find(params[:id])
    
    book_params = params.require(:book).permit(:year,:month,:inout,:category,:amount)
    if @book.update(book_params)
      redirect_to books_path
    else
      render :edit
    end  
  end

  def destroy
    # @book = Book.find(params[:id])
    @book.destroy
    # flash[:notice] = "削除しました"
    redirect_to books_path
  end

  private

  def set_book
    @book = Book.where(user_id: session[:user_id]).find(params[:id])
  end

  # application_controllerに転記したコード
  # def redirect_to_signin
  #   redirect_to signin_path if session[ :user_id].blank?
  # end
  

end