require 'rails_helper'

feature 'Creating Tickets' do
  let!(:project) { FactoryGirl.create(:project) }
  # let!(:user) { FactoryGirl.create(:user) }
  let!(:admin) { FactoryGirl.create(:admin_user) }

  before do
    @email = admin.email
    sign_in_as!(admin)
    define_permission!(admin, :view, project)
    define_permission!(admin, :"create tickerts", project)
    
    visit '/'
    click_link project.name
    click_link 'New Ticket'
  end
  
  scenario "Creating a ticket" do
    fill_in 'Title', with: 'Non-standards compliance'
    fill_in 'Description', with: 'My pages are ugly!'
    click_button 'Create Ticket'
    expect(page).to have_content('Ticket has been created.')
    
    within "#ticket #author" do
      expect(page).to have_content "Created by #{@email}"
    end
  end
  
  scenario 'Creating a ticket without valid attributes fails' do
    click_button 'Create Ticket'
    
    expect(page).to have_content("Ticket has not been created.")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Description can't be blank")
  end
  
  scenario 'Description must be longer than 10 characters' do
    fill_in 'Title', with: 'Non-standards compliance'
    fill_in 'Description', with: 'it sucks'
    click_button 'Create Ticket'
    
    expect(page).to have_content("Ticket has not been created.")
    expect(page).to have_content("Description is too short")
  end
end