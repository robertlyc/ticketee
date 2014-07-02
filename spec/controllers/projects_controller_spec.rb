require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do
  let(:user) {FactoryGirl.create(:user)}
  
  context "standard users" do
    before do
      sign_in(user)
    end
    
    { new: :get,
      create: :post,
      edit: :get,
      update: :put,
      destroy: :delete }.each do |action, method|
      it "cannot access the #{action} action" do
        send(method, action, :id => FactoryGirl.create(:project))
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eql "You must be an admin to do that."
      end
    end
  end
end
