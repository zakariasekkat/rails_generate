require "rails_generate/code_writer"

module RailsGenerate::Contracts
  class Create < RailsGenerate::CodeWriter

    def initialize(model_data)
      super(model_data)
      FileUtils.mkdir_p "app/concepts/#{@model_data.model_file}/contracts"
      @file_path = "app/concepts/#{@model_data.model_file}/contracts/create.rb"
    end

    def new_file_template_code
      "# frozen_string_literal: true

      class Contract::#{@model_data.model_class} < ApplicationRecord

end
"
    end

  end
end
