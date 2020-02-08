require "rails_generate/code_writer"

module RailsGenerate::Operations
  class Index < RailsGenerate::CodeWriter

    def initialize(model_data)
      super(model_data)
      folder_path = "app/concepts/#{@model_data.model_file}/operations"
      FileUtils.mkdir_p folder_path
      @file_path = "#{folder_path}/index.rb"
    end

    def new_file_template_code
      "# frozen_string_literal: true

module #{@model_data.model_class}::Operations
  class Index < ApplicationOperation
    step Finder(#{@model_data.model_class}::Finders::FindAll)
  end
end
"
    end

  end
end
