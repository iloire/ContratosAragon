class ContractsController < ApplicationController

  caches_action :index, :cache_path => Proc.new { |c| c.params },  :expires_in => 10.minute
  caches_action :show, :cache_path => Proc.new { |c| c.params },  :expires_in => 10.minute
  caches_action :searchByProcedure, :cache_path => Proc.new { |c| c.params } ,  :expires_in => 10.minute
  caches_action :searchByCompanyName, :cache_path => Proc.new { |c| c.params },  :expires_in => 10.minute
  caches_action :searchByDepartment, :cache_path => Proc.new { |c| c.params },  :expires_in => 10.minute
  caches_action :searchBySignedBy, :cache_path => Proc.new { |c| c.params },  :expires_in => 10.minute
  

  # GET /contracts
  # GET /contracts.xml
  def index
    @contractsAllCount = Contract.all.size #check if we should do this for performance reasons
    @contracts = Contract.paginate :page => params[:page], :per_page => 50
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contracts }
    end
  end

  # GET /contracts/1
  # GET /contracts/1.xml
  def show
    @contract = Contract.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contract }
    end
  end
  
  # Search by procedure
  def searchByProcedure
     @contracts = Contract.find :all, :conditions => [ " procedure like ? ", "%" + params[:procedimiento ] + "%"]
     @contractsAllCount = @contracts.size #check if we should do this for performance reasons
     @contracts = @contracts.paginate :page => params[:page], :per_page => 50
     respond_to do |format|
       format.html { render :template => "contracts/index.html.erb" }
       #format.html contracts/index.html.erb
       format.xml  { render :xml => @contracts }
     end
   end
  
   def searchByCompanyName
      @contracts = Contract.find :all, :conditions => [ " company_name like ? ", "%"+ params[:empresa ] + "%"]
      @contractsAllCount = @contracts.size #check if we should do this for performance reasons
      @contracts = @contracts.paginate :page => params[:page], :per_page => 50
      respond_to do |format|
        format.html { render :template => "contracts/index.html.erb" }
        #format.html contracts/index.html.erb
        format.xml  { render :xml => @contracts }
      end
    end
    
    def searchByDepartment
        @contracts = Contract.find :all, :conditions => [ " department like ? ", "%"+ params[:organismo ] + "%"]
        @contractsAllCount = @contracts.size #check if we should do this for performance reasons
        @contracts = @contracts.paginate :page => params[:page], :per_page => 50
        respond_to do |format|
          format.html { render :template => "contracts/index.html.erb" }
          #format.html contracts/index.html.erb
          format.xml  { render :xml => @contracts }
        end
    end
    
    def searchBySignedBy
        @contracts = Contract.find :all, :conditions => [ " signed_by like ? ", "%"+ params[:contratante ] + "%"]
        @contractsAllCount = @contracts.size #check if we should do this for performance reasons
        @contracts = @contracts.paginate :page => params[:page], :per_page => 50
        respond_to do |format|
          format.html { render :template => "contracts/index.html.erb" }
          #format.html contracts/index.html.erb
          format.xml  { render :xml => @contracts }
        end
    end
=begin
  # GET /contracts/new
  # GET /contracts/new.xml
  def new
    @contract = Contract.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contract }
    end
  end

  # GET /contracts/1/edit
  def edit
    @contract = Contract.find(params[:id])
  end

  # POST /contracts
  # POST /contracts.xml
  def create
    @contract = Contract.new(params[:contract])

    respond_to do |format|
      if @contract.save
        format.html { redirect_to(@contract, :notice => 'Contract was successfully created.') }
        format.xml  { render :xml => @contract, :status => :created, :location => @contract }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contract.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contracts/1
  # PUT /contracts/1.xml
  def update
    @contract = Contract.find(params[:id])

    respond_to do |format|
      if @contract.update_attributes(params[:contract])
        format.html { redirect_to(@contract, :notice => 'Contract was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contract.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contracts/1
  # DELETE /contracts/1.xml
  def destroy
    @contract = Contract.find(params[:id])
    @contract.destroy

    respond_to do |format|
      format.html { redirect_to(contracts_url) }
      format.xml  { head :ok }
    end
  end
=end  
end
