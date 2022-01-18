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

RSpec.describe 'The product admin' do
  it 'allows me to edit a product' do
    sign_in create(:admin_user)
    product1 = create(:product)
    product2 = create(:product)

    visit spree.admin_products_path
    # Clicks the edit icon for the first product
    within_row(1) { click_icon 'edit' }

    # ...
  end
end

RSpec.describe 'The product admin' do
  it 'displays the product SKU' do
    sign_in create(:admin_user)
    product1 = create(:product)
    product2 = create(:product)

    visit spree.admin_products_path

    within_row(1) do
      expect(column_text(1)).to eq(product1.sku)
    end
  end
end

RSpec.describe 'The orders admin' do
  it 'allows me to filter by variant' do
    sign_in create(:admin_user)
    product = create(:product)
    order = create(:order) do |o|
      create(:line_item, order: o, variant: product.master)
    end

    visit spree.admin_orders_path
    select2_search product.sku, from: 'Variant'
    click_button 'Filter results'

    expect(page).to have_content(order.number)
  end
end



