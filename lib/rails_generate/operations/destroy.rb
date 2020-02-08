require "rails_generate/code_writer"

module RailsGenerate::Operations
  class Destroy < RailsGenerate::CodeWriter

    def initialize(model_data)
      super(model_data)
      folder_path = "app/concepts/#{@model_data.model_file}/operations"
      FileUtils.mkdir_p folder_path
      @file_path = "#{folder_path}/destroy.rb"
    end

    def new_file_template_code
      "# frozen_string_literal: true

module #{@model_data.model_class}::Operations
  class Destroy < ApplicationOperation
    step Nested(Show)
    step :destroy

    def destroy(_ctx, model:, **)
      model.destroy
    end
  end
end
"
    end

  end
end
