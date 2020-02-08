module RailsGenerate
  class CodeWriter

    def initialize(model_data)
      @model_data = model_data
      @existed_code = ''
      @file_path = ""
    end



    def new_file_template_code
      ""
    end

    def existed_file_template_code
      @existed_code.insert(@existed_code.index('end'), "")
    end

    def existed_valid_template?
      if File.exist?(@file_path)
        @existed_code = File.read(@file_path)
        if @existed_code.include?(@model_data.model_class) and @existed_code.include?('class') and @existed_code.include?('end')
          return true
        end
      end
      false
    end

    def template
      if existed_valid_template?
        return existed_file_template_code
      end
      new_file_template_code
    end

    def generate
      code = template
      File.open(@file_path, "w") do |file|
        file.write code
      end
    end

  end
end
