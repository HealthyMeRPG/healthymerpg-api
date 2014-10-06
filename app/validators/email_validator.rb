require 'mail'

# taken from https://github.com/hengwoon/valid_email/blob/mail-2.6.1/lib/valid_email/validate_email.rb
class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    begin
      m = Mail::Address.new(value)

      # We must check that value contains a domain and that value is an email address
      r = m.domain && m.address == value

      # Check that domain consists of dot-atom-text elements > 1
      # In mail 2.6.1, domains are invalid per rfc2822 are parsed when they shouldn't
      # This is to make sure we cover those cases
      domain_dot_elements = m.domain.split(/\./)
      r &&= domain_dot_elements.none?(&:blank?) && domain_dot_elements.size > 1
    rescue StandardError => e
      r = false
    end
    record.errors[attribute] << (options[:message] || 'is invalid') unless r
  end
end
