module PayWithMe
  module Models
    class Transfer < Response
      def self.define_attr_methods_for(attribute)
        self.class_eval <<-METHOD, __FILE__, __LINE__ + 1
            def #{ attribute }!(value)      # def payer_account(value)
              @#{ attribute } = value       #   @payer_account = value
            end                             # end
        METHOD

        attr_reader attribute
      end
      private_class_method :define_attr_methods_for

      # transaction_id - generated by payment system
      # payment_id - provided by payer
      %i(
        payer_account
        payee_account
        payment_amount
        transaction_id
        payment_id
        amount
      ).each do |attr|
        define_attr_methods_for attr
      end

      def initialize
        yield self
      end
    end
  end
end