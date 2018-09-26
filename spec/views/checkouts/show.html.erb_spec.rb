require 'rails_helper'
require 'support/mock_data'

RSpec.describe "checkouts/show.html.erb", type: :view do
  include_context 'mock_data'

  before(:each) do
    assign(:transaction, mock_transaction)
  end

  it "renders the Transaction header" do
    render
    expect(rendered).to match /Transaction/
  end

  it "includes the transaction id" do
    render
    expect(rendered).to match /my_id/
  end

  it "includes the global transaction id" do
    render
    expect(rendered).to match /#{GlobalIdHack.encode_transaction('my_id')}/
  end

  it "includes the Credit Card Details" do
    render
    expect(rendered).to match /Payment/
  end

  it "includes the 'Return to checkout page' link" do
    render
    expect(rendered).to match /Test Another Transaction/
    expect(rendered).to match /checkouts\/new/
  end

  it "includes the 'Void' link when successful" do
    assign(:voidable, true)
    render
    expect(rendered).to match /Void This Transaction/
    expect(rendered).to match /checkouts\/void/
  end

  it "does not include the 'Void' link when unsuccessful" do
    assign(:voidable, false)
    render
    expect(rendered).not_to match /Void This Transaction/
    expect(rendered).not_to match /checkouts\/void/
  end
end

