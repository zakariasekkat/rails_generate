require "rails_generate/code_writer"

module RailsGenerate::Contracts
  class Create < RailsGenerate::CodeWriter

    def initialize(model_data)
      super(model_data)
      FileUtils.mkdir_p "app/concepts/#{@model_data.model_file}/contracts"
      @file_path = "app/concepts/#{@model_data.model_file}/contracts/create.rb"
    end

    def new_file_template_code
      properties = ""
      validations = ""
      @model_data.attributes.each do |attr|
        properties += "    property :#{attr}\n"
        validations += "      # required(:#{attr}).filled\n"
      end
      "# frozen_string_literal: true
module #{@model_data.model_class}::Contracts
  class Create < ApplicationForm
    # feature Dry

#{properties}
    # validation do

#{validations}
    # end
  end
end
"
    end

  end
end
