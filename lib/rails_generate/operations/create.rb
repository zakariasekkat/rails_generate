require "rails_generate/code_writer"

module RailsGenerate::Operations
  class Create < RailsGenerate::CodeWriter

    def initialize(model_data)
      super(model_data)
      folder_path = "app/concepts/#{@model_data.model_file}/operations"
      FileUtils.mkdir_p folder_path
      @file_path = "#{folder_path}/create.rb"
    end

    def new_file_template_code
      "# frozen_string_literal: true

module #{@model_data.model_class}::Operations
  class Create < ApplicationOperation
    step Model(#{@model_data.model_class})
    step Contract::Build(constant: #{@model_data.model_class}::Contracts::Create)
    step Contract::Validate(key: :#{@model_data.model_file})
    step Contract::Persist()
  end
end
"
    end

  end
end
