module Exceptions
  module Controller
    extend ActiveSupport::Concern

    included do
      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
      rescue_from ActionController::ParameterMissing, with: :parameter_missing
      rescue_from Exceptions::BaseError, with: :handle_api_error
      rescue_from ArgumentError, with: :argument_error
    end

    protected

    def check_required_fields(required, params, prefix)
      missing = []
      required.each { |field| missing.push(field) unless params[field]  }
      raise Exceptions::MissingInputParameterError.new(missing, prefix), "Missing Parameters!" unless missing.blank?
    end

    def argument_error(e)
      puts "#{e.inspect}"
      handle_api_error Exceptions::ArgumentError.new e.message
    end

    def parameter_missing(e)
      handle_api_error Exceptions::MissingParameter.new e.message.split(': ').last
    end

    def record_invalid(e)
      handle_api_error Exceptions::RecordInvalid.new e.message
    end

    def not_found(e)
      handle_api_error Exceptions::NotFound.new "#{e.model} with #{e.primary_key} '#{e.id}' not found"
    end

    def handle_api_error(e)
      render :json => e.error_object, status: e.http_error_code
    end
  end

  class BaseError < StandardError
    class_attribute :error_msg, :error_code, :http_error_code, :error_object
    self.error_msg = "Something went wrong"
    self.http_error_code = 400
    self.error_code = 0

    def error_object
      error = {code: self.error_code, message: self.error_msg}
      puts error.inspect
      return error
    end

    def initialize
    end

  end

  class BadRequest < BaseError
    self.http_error_code = 400
    self.error_code = 4000
    def initialize(message)
      self.error_msg = message unless message.blank?
    end
  end

  class MissingParameter < BaseError
    self.http_error_code = 400
    self.error_code = 4001
    def initialize(parameter)
      self.error_msg = "Missing parameter: '" + parameter + "'"
    end
  end

  class MissingInputParameterError < BaseError
    class_attribute :missing, :prefix
    def initialize(missing, prefix)
      self.missing = missing
      self.prefix = prefix
      self.error_msg = "Missing Required Parameters"
      self.http_error_code = 400
      self.error_code = 4002
      super()
    end

    def error_object
      error = super
      error[:missing_fields] = []
      self.missing.each do |field|
        description = field
        description = field + " is Required."
        description = prefix + "[" + field + "] is Required." if prefix
        pretty_name = field
        error[:missing_fields].push({attribute: field, pretty_name: pretty_name, description: description})
      end
      return error
    end
  end

  class Unauthorized < BaseError
    self.error_msg = "Unauthorized"
    self.http_error_code = 401
    self.error_code = 4010
    def initialize(message)
      self.error_msg = message unless message.blank?
    end
  end

  class InsufficientPrivileges < BaseError
    self.error_msg = "InsufficientPrivileges"
    self.http_error_code = 403
    self.error_code = 4030
    def initialize(message)
      self.error_msg = message unless message.blank?
    end
  end

  class RecordInvalid < BaseError
    self.error_msg = "Record invalid"
    self.http_error_code = 403
    self.error_code = 4031
    def initialize(message)
      self.error_msg = message.gsub('Validation failed: ', '') unless message.blank?
    end
  end

  class NotFound < BaseError
    self.error_msg = "Not found"
    self.http_error_code = 404
    self.error_code = 4040
    def initialize(message)
      self.error_msg = message unless message.blank?
    end
  end

  class NotAcceptable < BaseError
    self.error_msg = "Not Acceptable"
    self.http_error_code = 406
    self.error_code = 4060
    def initialize(message)
      self.error_msg = message unless message.blank?
    end
  end

  class Conflict < BaseError
    self.error_msg = "Conflict"
    self.http_error_code = 409
    self.error_code = 4090
    def initialize(message)
      self.error_msg = message unless message.blank?
    end
  end

  class ArgumentError < BaseError
    self.error_msg = "Argument error"
    self.http_error_code = 500
    self.error_code = 5000
    def initialize(message)
      self.error_msg = message unless message.blank?
    end
  end
end
