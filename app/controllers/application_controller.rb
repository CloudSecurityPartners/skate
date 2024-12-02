class ApplicationController < ActionController::Base
    include ApplicationHelper

    private
    def require_audit_trail
        unless ["GET","HEAD"].include?(request.request_method)
            raise "RequestNotAudited" unless audited?
        end
    end

    # TODO: Maybe this should be tied to request_id instead?
    def audited?
        Rails.cache.read('audited', raw: true)
    end

    def check_controller
        if request.env['PATH_INFO'].match(/\A\/admin/)
            unless Rails.cache.read('admin_request_processed', raw: true)
                raise "Admin Request didn't flow through admin controllers"
            end
        end
    end
end
