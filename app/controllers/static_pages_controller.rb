class StaticPagesController < ApplicationController
  def home
    @products = Product.newest.take(Settings.slider_number)
  end

  def help; end

  def about; end

  def contact; end
end
