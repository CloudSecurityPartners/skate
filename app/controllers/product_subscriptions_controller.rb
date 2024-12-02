class ProductSubscriptionsController < ApplicationController
    skip_before_action :verify_authenticity_token
    
    def show
        sub = ProductSubscription.find(params[:id])

        # Make sure user is authorized to test the webhook
        sub.validate!(params[:signature])

        render json: sub.notify!
    end

    def create
        ProductSubscription.create(
            url: params[:url],
            product_id: params[:product_id] || 1,
            user_id: 1
        )
    end
end
