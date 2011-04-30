require 'spec_helper'

describe "contracts/show.html.erb" do
  before(:each) do
    @contract = assign(:contract, stub_model(Contract,
      :title => "Title",
      :description => "Description",
      :contract_type => "Contract Type",
      :procedure => "Procedure",
      :budget_announced => "Budget Announced",
      :budget_adjudicated => "Budget Adjudicated",
      :idweb => 1,
      :company_name => "Company Name",
      :department => "Department",
      :signed_by => "Signed By",
      :resolution_date => "Resolution Date"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Description/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Contract Type/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Procedure/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Budget Announced/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Budget Adjudicated/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Company Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Department/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Signed By/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Resolution Date/)
  end
end
