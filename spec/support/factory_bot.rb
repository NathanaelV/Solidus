RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end

RSpec.describe 'The checkout flow' do
  it 'renders the delivery step' do
    user = create(:user)
    sign_in user
    # Generate an order in the `delivery` state
    order = Spree::TestingSupport::OrderWalkthrough.up_to(:address)
    order.update!(user: user)

    visit spree.checkout_path

    expect(page).to have_current_path('/checkout/delivery')
  end
end

RSpec.describe 'The product page' do
  it 'renders the price in EUR' do
    # Stub the global `currency` setting of the store
    stub_spree_preferences(currency: 'EUR')
    product = create(:product)

    visit spree.product_path(product)

    expect(page).to have_content('€100,00')
  end

  it 'renders the price in USD' do
    # Stub the global `currency` setting of the store
    stub_spree_preferences(currency: 'USD')
    product = create(:product)

    visit spree.product_path(product)

    expect(page).to have_content('$100.00')
  end
end


