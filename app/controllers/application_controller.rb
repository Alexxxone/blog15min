class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :tags
  private

  def tags
     @tags ||= Tag.all
  end
end
