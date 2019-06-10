class OrderListsController < ApplicationController
  before_action :valid_order

  def update
    flash[:danger] = t("cant_order") unless @order_list.update_attributes list_params
    redirect_to edit_order_path(@order)
  end

  def destroy
    @order_list.destroy
    if @order.order_lists.empty?
      @order.destroy
      redirect_to orders_path
    else
      redirect_to edit_order_path(@order)
    end
  end

  private

  def list_params
    params.require(:order_list).permit :quantity
  end

  def valid_order
    @order = current_user.orders.find_by id: params[:order_id]
    @order_list = @order.order_lists.find_by id: params[:id]
    return if @order&.pending? && @order_list
    flash[:danger] = t "order_not_valid"
    redirect_to orders_path
  end
end
