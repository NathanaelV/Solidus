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

