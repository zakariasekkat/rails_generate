require "rails_generate/code_writer"

module RailsGenerate
  class Router < CodeWriter

    def initialize(model_data)
      super(model_data)
      @file_path = "config/routes.rb"
    end

    def existed_valid_template?
      @existed_code = File.read(@file_path)
      true
    end

    def getEndPositionOfRouter
      @spaces = ''
      index = @existed_code.index("scope :api") - 1
      while @existed_code[index] != "\n" do
        @spaces += @existed_code[index]
        index -= 1
      end
      @existed_code.index("\n#{@spaces}end")
    end

    def existed_file_template_code
      if @existed_code.include?("resources :#{@model_data.table_name}")
        return super
      end
      @existed_code.insert(getEndPositionOfRouter, "
#{@spaces}  resources :#{@model_data.table_name}, only: %i[index create destroy show update]")
    end


  end
end
