class Admin::OrdersController < AdminController
  before_action :load_order, only: %i(update show)
  before_action :calc_sub_total, only: :show

  def show; end

  def index
    query_search
    respond_to do |format|
      format.html{render :index}
      format.js
    end
  end

  def update
    @order.update_attributes order_params if @order.pending?
    redirect_to admin_orders_path
  end

  private

  def order_params
    params.require(:order).permit :status
  end

  def query_search
    @orders = Order.newest.by_status(params[:search]).paginate(
      page: params[:page], per_page: Settings.index_per_page
    )
  end

  def load_order
    @order = Order.find_by id: params[:id]
  end
end
