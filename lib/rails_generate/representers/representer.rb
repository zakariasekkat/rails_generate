require "rails_generate/code_writer"

module RailsGenerate::Representers
  class Representer < RailsGenerate::CodeWriter

    def initialize(model_data)
      super(model_data)
      folder_path = "app/representers"
      FileUtils.mkdir_p folder_path
      @file_path = "#{folder_path}/#{@model_data.model_file}_representer.rb"
    end

    def new_file_template_code
      properties = ""
      @model_data.attributes.each do |attr|
        properties += "  property :#{attr}\n"
      end
      "# frozen_string_literal: true

class #{@model_data.model_class}Representer < ApplicationJsonRepresenter

#{properties}
end
"
    end

  end
end
