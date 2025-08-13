# typed: strict

module ViewComponents
  class DateTime < ViewComponent::Base
    extend T::Sig

    sig { params(datetime: ActiveSupport::TimeWithZone).void }
    def initialize(datetime)
      @datetime = datetime
    end

    sig { returns(String) }
    def call
      @datetime.strftime("%d.%m.%Y %H:%S")
    end
  end
end
