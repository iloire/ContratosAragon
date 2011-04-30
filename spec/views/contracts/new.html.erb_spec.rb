require 'spec_helper'

describe "contracts/new.html.erb" do
  before(:each) do
    assign(:contract, stub_model(Contract,
      :title => "MyString",
      :description => "MyString",
      :contract_type => "MyString",
      :procedure => "MyString",
      :budget_announced => "MyString",
      :budget_adjudicated => "MyString",
      :idweb => 1,
      :company_name => "MyString",
      :department => "MyString",
      :signed_by => "MyString",
      :resolution_date => "MyString"
    ).as_new_record)
  end

  it "renders new contract form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => contracts_path, :method => "post" do
      assert_select "input#contract_title", :name => "contract[title]"
      assert_select "input#contract_description", :name => "contract[description]"
      assert_select "input#contract_contract_type", :name => "contract[contract_type]"
      assert_select "input#contract_procedure", :name => "contract[procedure]"
      assert_select "input#contract_budget_announced", :name => "contract[budget_announced]"
      assert_select "input#contract_budget_adjudicated", :name => "contract[budget_adjudicated]"
      assert_select "input#contract_idweb", :name => "contract[idweb]"
      assert_select "input#contract_company_name", :name => "contract[company_name]"
      assert_select "input#contract_department", :name => "contract[department]"
      assert_select "input#contract_signed_by", :name => "contract[signed_by]"
      assert_select "input#contract_resolution_date", :name => "contract[resolution_date]"
    end
  end
end
