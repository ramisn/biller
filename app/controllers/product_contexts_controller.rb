class ProductContextsController < ApplicationController
	respond_to :html,:js

  load_and_authorize_resource
  #add_breadcrumb "Products context", :product_product_contexts_path
  #Controller

  def index
    #params[:sort] ||= "context_priority"
    #params[:sort_dir] ||= "asc"
    #filters = params.dup
    
    @product=Product.find(params[:product_id])
    add_breadcrumb "Products", :products_path
    add_breadcrumb   @product.name, :product_product_contexts_path
    add_breadcrumb "#{@product.name} contexts ", :product_product_contexts_path

    @all=@product.product_contexts
    @n= @all.sort() #TDO (sorting is not working based on context_priority)
  end
  def show
      add_breadcrumb "Products", :products_path

     @products_contexts=ProductContext.find(params[:id])
      @product=Product.find(@products_contexts.product_id)
     add_breadcrumb "#{@product.name} contexts ", :product_product_contexts_path

  end
  def new

     @product=Product.find(params[:product_id])
     @product_context=ProductContext.new
     #add_breadcrumb @product.name,:products_context_path
     add_breadcrumb "#{@product.name} contexts ", :product_product_contexts_path
     @disply="none"
    end
  
  def create
     @product_context=ProductContext.new(params[:product_context])
     @product_context.product_id=params[:product_id]
     if @product_context.save
      flash[:notice] = "Contexts Added Successfully!"
      redirect_to :action => "index"
      else
      @product=Product.find(params[:product_id])
      render "new"
      end

  end

def edit

      add_breadcrumb "Products", :products_path
        
      @product=Product.find(params[:product_id])
     
      
  end


  def update
      
      
      @check=params[:start_time]
      
      
      @product = @product_context.product
      if @product_context.update_attributes(params[:product_context])
         flash[:notice] = "Contexts Updated Successfully!"
         redirect_to :action => "index",:id=>@product_context.id
      else
        render 'edit'
      end
  end

  def destroy

    @product_cont_del=ProductContext.find(params[:id])
    @context=@product_cont_del.context_type
    @pro_no=@product_cont_del.product_id
    @product=Product.find(@pro_no)


    if @product_cont_del.destroy
             flash[:notice]=" #{@context} Context For The #{@product.name} Product is deleted"
      redirect_to :controller => "product_contexts",:action => "index"
    end
  end

  def delete

  end
end
