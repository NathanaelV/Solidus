require 'spree/testing_support/authorization_helpers'

require 'spree/testing_support/capybara_ext'

require 'spree/testing_support/order_walkthrough'

require 'spree/testing_support/preferences'

RSpec.describe 'The product admin' do
  stub_authorization!

  it 'allows me to view the products' do
    product = create(:product)

    visit spree.admin_path
    click_link 'Products'

    expect(page).to have_content(product.name)
  end
end

RSpec.describe 'The product admin' do
  custom_authorization! do
    can :read, Spree::Product
  end

  it 'allows me to view the products' do
    sign_in create(:user)
    product = create(:product)

    visit spree.admin_path
    click_link 'Products'

    expect(page).to have_content(product.name)
  end

  it 'does not allow me to edit products' do
    sign_in create(:user)
    product = create(:product)

    visit spree.edit_admin_product_path(product)

    expect(page).to have_content('Access denied')
  end
end

