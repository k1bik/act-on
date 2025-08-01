# typed: strict

module ViewComponents
  class FormInput < ViewComponent::Base
    extend T::Sig

    sig do
      params(
        form_object: ActionView::Helpers::FormBuilder,
        field_name: Symbol,
        label: String,
        placeholder: T.nilable(String),
        classes: T.nilable(String),
        input_html: T.nilable(T::Hash[Symbol, T.any(String, Symbol, T::Boolean)])
      ).void
    end
    def initialize(form_object, field_name, label:, placeholder: nil, classes: nil, input_html: {})
      @form_object = form_object
      @field_name = field_name
      @label = label
      @placeholder = placeholder
      @classes = classes
      @input_html = input_html
    end

    private

    sig { returns(String) }
    def errors = @form_object.object.errors[@field_name].join(", ")

    sig { returns(T::Boolean) }
    def required?
      @form_object.object.class.validators_on(@field_name).any? do |validator|
        validator.is_a?(ActiveModel::Validations::PresenceValidator)
      end
    end

    sig { returns(T.nilable(Integer)) }
    def max_length
      @form_object.object.class.validators_on(@field_name).find do |validator|
        validator.is_a?(ActiveModel::Validations::LengthValidator) && validator.options[:maximum]
      end&.options&.fetch(:maximum)
    end
  end
end
