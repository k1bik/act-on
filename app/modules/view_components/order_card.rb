# typed: strict

module ViewComponents
  class OrderCard < ViewComponent::Base
    extend T::Sig

    sig { params(order: Order).void }
    def initialize(order)
      @order = order
    end

    # TODO: move to JS
    sig { returns(T::Boolean) }
    def long_comment?
      return false if @order.comment.blank?

      T.must(@order.comment).size > 100
    end
  end
end
