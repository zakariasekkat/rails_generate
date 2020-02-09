require "rails_generate/code_writer"

module RailsGenerate::Tests
  class Fabricator < RailsGenerate::CodeWriter

    def initialize(model_data)
      super(model_data)
      @file_path = "test/fabricators/#{@model_data.table_name}_fabricator.rb"
    end


    def new_file_template_code
      properties = ""
      @model_data.attributes.each do |attr|
        properties += "  #{attr} { Faker::Lorem.word } \n"
      end
      "# frozen_string_literal: true

Fabricator :#{@model_data.model_file} do

#{properties}
end

"
    end

  end
end
