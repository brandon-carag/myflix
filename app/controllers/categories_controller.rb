class CategoriesController < ApplicationController
  def show
    @category=Category.find(params[:id])
    # test_comment3
  end
end