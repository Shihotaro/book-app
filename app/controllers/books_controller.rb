class BooksController < ApplicationController
    
    def index
        @books = Book.all
    end

    def show
        # paramsは、引数で指定した値をURLから持ってくる
        @book = Book.find(params[:id])
    end

    def new
        # 空のクラスを用意
        @book = Book.new
    end

    def create
        # URLのbookからpermit()内の要素を代入
        book_params = params.require(:book).permit(:year, :month, :inout, :category, :amount)
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
      @book = Book.find(params[:id])
    end

    def update
      @book = Book.find(params[:id])
      
      book_params = params.require(:book).permit(:year,:month,:inout,:category,:amount)
      if @book.update(book_params)
        redirect_to books_path
      else
        render :edit
      end  
    end
end