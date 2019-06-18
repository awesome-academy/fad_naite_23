class OrdersController < ApplicationController
  before_action :load_cart_products, only: :create
  before_action :load_order, except: %i(index new create)
  before_action :calc_sub_total, only: %i(edit show)

  def index
    @orders = current_user.orders.newest.paginate page: params[:page],
      per_page: Settings.index_per_page
  end

  def show; end

  def new
    @order = current_user.orders.new
  end

  def edit; end

  def create
    @order = current_user.orders.build order_params
    @products.each do |p|
      unit_sold_price = p.discount ? p.price * p.discount : p.price
      @order.order_lists.build product_id: p.id, quantity: @cart[p.id.to_s],
        unit_sold_price: unit_sold_price
    end
    begin_order_transaction
  end

  def update
    if @order.pending? && @order.update_attributes(order_params)
      flash[:update] = t "update_success"
      redirect_to orders_path
    else
      flash[:update] = t "update_failed"
      render :edit
    end
  end

  def destroy
    if @order.pending?
      flash[:success] = t "delete" if @order.destroy
    else
      flash[:danger] = t "delete_failed"
    end
    redirect_to orders_path
  end

  private

  def load_cart_products
    if @cart.empty?
      flash[:danger] = t "buy_first"
      redirect_to @products
    else
      @products = Product.newest.in_cart(@cart.keys)
    end
  end

  def order_params
    params.require(:order).permit :receiver_name, :receiver_phone_number,
      :delivery_address
  end

  def load_order
    return if @order = current_user.orders&.find_by(id: params[:id])
    flash[:danger] = t "order_not_found"
    redirect_to orders_path
  end

  def calc_sub_total
    @sub_total = @order.order_lists.reduce(0) do |sum, item|
      sum + item.unit_sold_price * item.quantity
    end
  end

  def begin_order_transaction
    Order.transaction do
      @order.save!
    end
    redirect_to @order
  rescue
    flash[:danger] = t "cant_order"
    redirect_to products_path
  end
end
