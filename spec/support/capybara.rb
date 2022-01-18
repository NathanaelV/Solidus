RSpec.configure do |config|
  config.before(:each, type: :system) do |example|
    if example.metadata[:js]
      driven_by :selenium_chrome_headless
    else
      driven_by :rack_test
    end
  end
end

RSpec.describe 'The option types admin' do
  it 'allows me to delete the option types' do
    sign_in create(:admin_user)
    option_type = create(:option_type)

    visit spree.admin_path
    click_link 'Products'
    click_link 'Option Types'
    click_icon 'trash'

    expect(page).to have_content('has been successfully removed')
  end
end