# typed: strict

module ViewComponents
  class TextInput < ViewComponent::Base
    extend T::Sig

    sig do
      params(
        form_object: ActionView::Helpers::FormBuilder,
        field_name: Symbol,
        label: String,
        placeholder: T.nilable(String)
      ).void
    end
    def initialize(form_object, field_name, label:, placeholder: nil)
      @form_object = form_object
      @field_name = field_name
      @label = label
      @placeholder = placeholder
    end

    sig { returns(String) }
    def errors = @form_object.object.errors[@field_name].join(", ")

    sig { returns(T::Boolean) }
    def required?
      @form_object.object.class.validators_on(@field_name).any? { _1.is_a?(ActiveModel::Validations::PresenceValidator) }
    end
  end
end
