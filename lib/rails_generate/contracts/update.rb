require "rails_generate/code_writer"

module RailsGenerate::Contracts
  class Update < RailsGenerate::CodeWriter

    def initialize(model_data)
      super(model_data)
      folder_path = "app/concepts/#{@model_data.model_file}/contracts"
      FileUtils.mkdir_p folder_path
      @file_path = "#{folder_path}/update.rb"
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
  class Update < ApplicationForm
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
