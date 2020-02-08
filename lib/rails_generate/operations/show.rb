require "rails_generate/code_writer"

module RailsGenerate::Operations
  class Show < RailsGenerate::CodeWriter

    def initialize(model_data)
      super(model_data)
      folder_path = "app/concepts/#{@model_data.model_file}/operations"
      FileUtils.mkdir_p folder_path
      @file_path = "#{folder_path}/show.rb"
    end

    def new_file_template_code
      "# frozen_string_literal: true

module #{@model_data.model_class}::Operations
  class Show < ApplicationOperation
    step Model(#{@model_data.model_class}, :find_by)
  end
end
"
    end

  end
end
