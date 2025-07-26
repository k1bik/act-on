# typed: strict

module ViewComponents
  class Modal < ViewComponent::Base
    extend T::Sig

    SIZES = T.let([
      SMALL = "small",
      MEDIUM = "medium",
      LARGE = "large"
    ].freeze, T::Array[String])

    sig { params(size: String).void }
    def initialize(size: SMALL)
      @size = T.let(size, String)
    end

    sig { returns(String) }
    def width
      case @size
      when SMALL
        "w-[400px]"
      when MEDIUM
        "w-[600px]"
      when LARGE
        "w-[800px]"
      else
        raise "Invalid size: #{@size}"
      end
    end
  end
end
