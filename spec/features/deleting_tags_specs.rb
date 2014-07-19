require 'rails_helper'

feature "Deleting tags" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project) }
  let!(:ticket) do
    FactoryGirl.create(:ticket,
            project: project,
            tag_names: "this-tag-must-die",
            user: user)
  end

  before do
    sign_in_as!(user)
    define_permission!(user, "view", project)
    define_permission!(user, "tag", project)
    visit '/'
    click_link project.name
    click_link ticket.title
  end

  scenario "Deleting a tag", js: true do
    click_link "delete-this-tag-must-die"
    expect(page).to_not have_content("this-tag-must-die")
  end
end