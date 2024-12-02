class CartsController < ApplicationController
    before_action :set_cart_for_user, only: [:show, :edit, :update, :destroy]
    def index
        require_access!
        @carts = Cart.all
        render json: @carts
    end

    def load_card
        @cart = Marshal.load(params[:serialized_cart])
    end

    def show
    end

    def edit
    end

    def update
        product_info = JSON.load(@cart.product_info)
        product_info ||= {}

        product_info[params[:id]] = params[:quantity].to_i
            
        @cart.product_info = JSON.dump(product_info)
        @cart.total = total_for_cart(product_info)
        @cart.save

        flash[:notice] = "Cart updated"
        redirect_back(fallback_location: root_path)
    end

    def destroy
        @cart.product_info = JSON.dump([])
        @cart.save
    end

    private
    def set_cart_for_user
        @cart = cart_for_user
    end

    def total_for_cart(products)
        total = 0
        products.each do |k,v|
            product = Product.find(k)
            total += product.price * v
        end
        total
    end
end
