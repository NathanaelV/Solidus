RSpec.describe "Product page", type: :system do
  it "shows the product's description" do
    visit "/products/solidus-shirt"

    expect(page).to have_text("Solidus-branded T-shirt")
  end

  it "allows me to add a product to my cart", :js do
    visit "/products/solidus-shirt"

    click_button "Add to Cart"

    expect(page).to have_text("Product was added to the cart!")
  end
end

