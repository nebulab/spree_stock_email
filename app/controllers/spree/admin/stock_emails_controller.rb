module Spree
  module Admin
    class StockEmailsController < ResourceController
      before_action :load_data

      protected
        def load_data
          @summary = Spree::StockEmail.summary
          @awaiting_users = Spree::StockEmail.awaiting_users
          @notified_users = Spree::StockEmail.notified_users
        end

        def collection

          return @collection if defined?(@collection)
          params[:q] ||= HashWithIndifferentAccess.new

          params[:q][:s] ||= 'id desc'
          @collection = super
          @search = @collection.ransack(params[:q])
          @collection = @search.result(distinct: true).
            page(params[:page]).
            per(params[:per_page] || Spree::StockEmailConfig::Config.per_page)

          @collection
        end
    end
  end
end
