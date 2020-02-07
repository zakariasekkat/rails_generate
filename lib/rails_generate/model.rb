module RailsGenerate
  class Model

    def initialize(model_data)
      @model_data = model_data
    end

    def template
"
class #{@model_data.model_class} < ApplicationRecord

end
"
    end

    def generate

      model_path = File.exist?("app/models/#{@model_data.model_file}.rb") ?
                     "app/models/#{@model_data.model_file}_generated.rb" :
                     "app/models/#{@model_data.model_file}.rb";

      File.open(model_path, "w") do |file|
        file.write template
      end
    end

  end
end
