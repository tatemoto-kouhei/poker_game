class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  def sayhello
    render :html => "hello!"
  end
  protect_from_forgery :with => :exception
  def check

    render :html => "hello!"

  end
end
