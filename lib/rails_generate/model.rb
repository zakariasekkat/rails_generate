require "rails_generate/code_writer"

module RailsGenerate
  class Model < CodeWriter

    def initialize(model_data)
      super(model_data)
      @file_path = "app/models/#{@model_data.model_file}.rb"
    end

    def new_file_template_code
      "# frozen_string_literal: true

class #{@model_data.model_class} < ApplicationRecord

end
"
    end



  end
end
