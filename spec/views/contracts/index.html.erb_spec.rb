require 'spec_helper'

describe "contracts/index.html.erb" do
  before(:each) do
    assign(:contracts, [
      stub_model(Contract,
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
      ),
      stub_model(Contract,
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
      )
    ])
  end

  it "renders a list of contracts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Contract Type".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Procedure".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Budget Announced".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Budget Adjudicated".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Company Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Department".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Signed By".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Resolution Date".to_s, :count => 2
  end
end
