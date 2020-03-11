class OrdersController < ApplicationController

  def show

  end

  def new

  end

  def create
    # on créer une order
    @order = Order.new(user:current_user)
    @cart = Cart.where(user_id: current_user.id)

    # on copie les items du cart dans l'order item
    @cart_items = CartItems.where(cart_id:@cart)
    
    @cart_items.each do |c|
      @order_item = OrderItem.new(order:@order,item:c.item)
      if @order_item.save
        puts "O-K"
      else
        puts @order_item.errors.full_messages
      end
    end

    unless @order_item.nil?
      if @order.save
        puts "ORDER CREATED"
        flash[:confirm_order] = "Merci ta commande a bien été prise en compte"
        @confirm_order = "Merci ta commande a bien été prise en compte"
        redirect_to root_path(:new_order => @confirm_order)
      else
        @fail_order = "Ta commande est vide..."
        puts @order.errors.full_messages
        redirect_to root_path(:fail_new_order => @fail_order)
      end
    else
        @fail_order = "Ta commande est vide..."
        redirect_to root_path(:fail_new_order => @fail_order)
    end

  end

end