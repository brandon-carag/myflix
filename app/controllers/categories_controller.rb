class CategoriesController < ApplicationController
  def show
    @category=Category.find(params[:id])
    # test_comment4
  end
end