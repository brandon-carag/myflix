require 'spec_helper'

describe ReviewsController do 
  describe 'GET new' do
    it 'sets @review'

  end

  describe 'POST create' do
    context 'input is valid' do
      it 'sets @review'
      it 'displays success message'
      it 'redirects to post_path'
    end

    context 'input is invalid' do
      it 'sets @review'
      it 'displays failure message'
      it 'renders post show template'
      it 'does not display the review'
    end
  end




  
end