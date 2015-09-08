require 'spec_helper'

feature 'Remove a person from a group' do

  let(:person) { create(:person) }
  let(:group) { create(:group) }

  before do
    visit new_person_session_path
    sign_in person
  end

  context 'the non-admin' do

    it 'cannot see the remove form' do
      person.join!(group, 'StudentMembership')
      go_to_group_page
      expect(page).to_not have_selector('.remove-from-group')
    end

  end

  context 'the admin' do

    before do
      person.update_attribute(:admin, true)
      person.join!(group, 'StudentMembership')
      go_to_group_page
    end

    it 'can see the remove form' do
      expect(page).to have_selector('.remove-from-group')
    end

    it 'can remove the person' do
      within '.group-info' do
        find(".remove-from-group").click
      end

      expect(current_path).to eq('/groups')
      go_to_group_page
      expect(page).to_not have_selector('.remove-from-group')
    end

  end

  def go_to_group_page
    visit '/groups/'
    click_link 'Test Group'
  end
end
