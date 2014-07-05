require 'rails_helper'

feature "hidden links" do
  let(:user) {FactoryGirl.create(:user)}
  let(:admin) {FactoryGirl.create(:admin_user)}
  let(:project) {FactoryGirl.create(:project)}
  
  context "anonymous users" do
    scenario "cannot see the New Project link" do
      visit '/'
      assert_no_link_for 'New Project'
    end
    
    scenario "cannot see the Edit Project link" do
      visit project_path(project)
      assert_no_link_for "Edit Project"
    end
    
    scenario "cannot see the Delete Project link" do
      visit project_path(project)
      assert_no_link_for "Delete Project"
    end
  end
  
  context "regular users" do
    before {sign_in_as!(user)}
    
    scenario "New ticket link is shown to a user with permission" do
      define_permission!(user, :view, project)
      define_permission!(user, :"create tickets", project)
      visit project_path(project)
      assert_link_for "New Ticket"
    end
    
    scenario "New ticket link is hidden to a user without permission" do
      define_permission!(user, :view, project)
      visit project_path(project)
      assert_no_link_for "New Ticket"
    end
    
    scenario "cannot see the New Project link" do
      visit '/'
      assert_no_link_for 'New Project'
    end
    
    scenario "cannot see the Edit Project link" do
      visit project_path(project)
      assert_no_link_for "Edit Project"
    end
    
    scenario "cannot see the Delete Project link" do
      visit project_path(project)
      assert_no_link_for "Delete Project"
    end
  end
  
  context "admin users" do
    before {sign_in_as!(admin)}
    scenario "can see the New Project link" do
      visit '/'
      assert_link_for 'New Project'
    end
    
    scenario "can see the Edit Project link" do
      visit project_path(project)
      assert_link_for "Edit Project"
    end
    
    scenario "can see the Delete Project link" do
      visit project_path(project)
      assert_link_for "Delete Project"
    end
    
    scenario "New ticket link is shown to admins" do
      visit project_path(project)
      assert_link_for "New Ticket"
    end
  end
end