require 'pry'
class ProductCategoriesController < ApplicationController
    def index
        @categories = ProductCategory.all
    end

    def show
        @category = ProductCategory.find(params[:id])
        @products = @category.products

        AuditLogEntry.event(
            event: event_for_auditing("ProductCategory#show"),
            actor_id: actor_for_auditing,
            target: target_for_auditing(@products),
            ip_address: ip_for_auditing
        )
    end
end
