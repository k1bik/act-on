# typed: strict

module ViewComponents
  class ErrorMessage < ViewComponent::Base
    extend T::Sig

    sig { params(error_message: String).void }
    def initialize(error_message)
      @error_message = error_message
    end

    sig { returns(String) }
    def call
      tag.span class: "text-red-500 text-xs absolute -bottom-4" do
        @error_message
      end
    end
  end
end
