module Spree
  module Admin
    module StockEmailsHelper
      def variant_extended_name(variant)
        "#{variant.name} (#{variant_options_text(variant)})"
      end

      def variant_options_text(variant)
        variant.option_values.map { |ov| "#{ov.presentation}" }.to_sentence({:words_connector => ", ", :two_words_connector => ", "})
      end
    end
  end
end
