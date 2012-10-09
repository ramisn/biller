class InvoicesController < ApplicationController
   respond_to :html, :js
  load_and_authorize_resource
  add_breadcrumb "Invoices", :invoices_path
  
  def index
   if params[:page].to_i > 1
      @count = (params[:page].to_i - 1)*10
   elsif
     @count = 0
    end
    @org_id=current_user.organization_id
    @organization=Organization.find(@org_id)
    @invoice=@organization.invoices
    #@invoice_page = @invoice.order(:id).page params[:page]
    @invoice = @invoice.order(:id).page params[:page]
 end
  
  def new
    @invoice=Invoice.new
    @account = Account.new
    @org=current_user.organization
    @account_current_user = @org.accounts                     
  end
  
	def create
		@invoice=Invoice.new(params[:invoice])
		@invoice.account_id = params[:account_id]
		@invoice.organization_id=current_user.organization_id
		@org=current_user.organization
    @account_current_user = @org.accounts
    #@amount=amount.to_f * (1 + tax.to_f / 100)
    @invoice.total_amount= params[:gtotal]
    #raise @invoice.total_amount
    #@invoice.total_amount = params[:gtotal] + (params[:gtotal] * tax.to_f / 100)
    n=params[:pn]
		if @invoice.save
      if n!=nil
        for i in 0...n.length
          @line=LineItem.new
          @line.invoice_id=@invoice.id
          @line.name=params[:pn][i]
          @line.quantity=params[:qty][i]
          @line.unit_price=params[:up][i]
          @line.save
        end
        flash[:notice]="Invoice is created"
        redirect_to :action=>"show", :id=>@invoice.id
      else
       flash[:notice]="Please Add Line Items"
       redirect_to :action=>"new"
      end
    else
      render 'new'    
    end
  end
 

 def show
    @invoice=Invoice.find(params[:id])
    @lineitems=@invoice.line_items
    add_breadcrumb @invoice.id, invoice_path(@invoice.id)
    @invoice.organization_id=current_user.organization_id
    @user=User.find_by_organization_id(@invoice.organization_id)
    @account=@invoice.account
    @print = false
     if params[:print]
      @print = true
      render :layout => false
      end
  end

  def edit
    @line_items=@invoice.line_items
    @org=current_user.organization
    @account_current_user = @org.accounts

  end
  
  def update
    @invoice.total_amount= params[:gtotal]
    @lineitems_prev=@invoice.line_items  
    n=params[:pn]
	  if @invoice.update_attributes(params[:invoice])
      if n!=nil
        @lineitems_prev.each do |lineitem|
          lineitem.destroy
        end
        for i in 0...n.length
          @line=LineItem.new
          @line.invoice_id=@invoice.id
          @line.name=params[:pn][i]
          @line.quantity=params[:qty][i]
          @line.unit_price=params[:up][i]
          @line.save
        end
        flash[:notice]="Invoice is updated"
        redirect_to :action=>"show", :id=>@invoice.id
      else
       flash[:notice]="Please Add Line Items"
       redirect_to :back
      end
    else
      redirect_to :action =>  "show"
    end
  end
  
  def destroy
    
  end
  
  def find
   like= params[:data][:autocomplete]["keyword"]
   like=like.concat("%")
   @found=Product.where( "products.organization_id = ? AND products.key like ?" ,current_user.organization_id,like )
   render :layout => false

  end



def test
  @line_item=LineItem.new

  @line_item.name= params[:name]
  @line_item.quantity= params[:quantity]
  @line_item.unit_price= params[:unitprice]

  @line_item.save
  n=@line_item.id
 
if session["line_item"]==nil
session["line_item"]= {}
end
session["line_item"][n]=@line_item.id

  end

  def find_context
  
    #raise params.inspect
    @product=Product.find(params[:id])
    if params[:value]== nil
      @current_time=Time.now 
      else
      @current_time= DateTime.parse(params[:value])
    end 
    @arr1=Array.new
    @arr=Array.new
    j=0
    @productcontext= @product.product_contexts
    #raise @productcontext.inspect
    if @productcontext!=nil
      @productcontext.each do |i|
        if i.start_time != nil
          if @current_time >= i.start_time
            if @current_time<=i.end_time  
              @arr[j]=i.context_priority
              @arr1[j]=i.id
              j=j+1
            end
          end   
        end
      end   
      n=@arr.find_index @arr.min
      if n!=nil
        id=@arr1[n]
        @price=ProductContext.find(id).unit_price
        else
        @price=@product.unit_price
      end
    else
      @price=@product.unit_price
    end
    render :layout => false
  #raise n.inspect
end
end
