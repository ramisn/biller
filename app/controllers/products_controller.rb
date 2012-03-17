class ProductsController < ApplicationController
  load_and_authorize_resource
  add_breadcrumb "Products", :products_path
  
  def index
    params[:sort] ||= "name"
    params[:sort_dir] ||= "asc"
    filters = params.dup
    filters[:organization_id] = current_user.organization.id
 #   @contact=AccountContact.find(params[:id])

    @products = Product.search(filters)
    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => @products }
      format.xml  { render :xml => @products }
    end
  end
  
  def new   
    add_breadcrumb "New", new_product_path
  end
  
  def edit
    add_breadcrumb @product.name, product_path(@product)
    add_breadcrumb "Edit", edit_product_path(@product)
  end

  def update
    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html {
          flash[:success] = "Product was successfully updated"
          redirect_to product_path(@product)
        }
        format.json { head :ok }
      else
        format.html { render :action => :edit }
        format.json { render :json => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  def create   
    respond_to do |format|
      @product.organization = current_user.organization
      @product.user_id = current_user.id
    
      if @product.save         
        format.html { 
          flash[:success] = "Product was created successfully"
          redirect_to product_path(@product)
        }
        format.json  { render :json => @product, :status => :success }
      else
        format.html  { render :action => :new }
        format.json  { render :json => @product.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def show
    add_breadcrumb @product.name, product_path(@product)

    respond_to do |format|
      format.html  # show.html.erb
      format.json  { render :json => @product }
    end
  end
end
