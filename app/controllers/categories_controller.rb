class CategoriesController < ApplicationController
  def show
    @category=Category.find(params[:id])
    # test_comment5
  end
end