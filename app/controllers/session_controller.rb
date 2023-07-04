class SessionController < ApplicationController
  before_action :redirect_to_books, only: [:new, :create
  ]

  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user.present? && user.authenticate(params[:password])
      flash[:notice] = 'ログインしました'
      session[:user_id] = user.id
      redirect_to books_path
    else
      flash.now[:alert] = 'ログインに失敗しました'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to signin_path
  end
  

  private

  def redirect_to_books
    return unless session[:user_id].present?

    flash[:notice] = 'ログインしました111111111111'
    redirect_to books_path
  end
end
