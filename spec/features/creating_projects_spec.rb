require 'rails_helper'

feature 'Creating Projects' do
  scenario "can create a project" do
    visit '/'
    
    click_link 'New Project'
    
    fill_in 'Name', with: 'Textmate 2'
    fill_in 'Description', with: 'A text-editor for OS X'
    click_button 'Create Project'
    
    expect(page).to have_content('Project has been created.')
  end
end