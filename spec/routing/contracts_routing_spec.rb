require "spec_helper"

describe ContractsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/contracts" }.should route_to(:controller => "contracts", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/contracts/new" }.should route_to(:controller => "contracts", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/contracts/1" }.should route_to(:controller => "contracts", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/contracts/1/edit" }.should route_to(:controller => "contracts", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/contracts" }.should route_to(:controller => "contracts", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/contracts/1" }.should route_to(:controller => "contracts", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/contracts/1" }.should route_to(:controller => "contracts", :action => "destroy", :id => "1")
    end

  end
end
