require "rails_generate/code_writer"

module RailsGenerate::Finders
  class FindAll < RailsGenerate::CodeWriter

    def initialize(model_data)
      super(model_data)
      folder_path = "app/concepts/#{@model_data.model_file}/finders"
      FileUtils.mkdir_p folder_path
      @file_path = "#{folder_path}/find_all.rb"
    end

    def new_file_template_code
      filder_by = ""
      apply = ""
      @model_data.attributes.each do |attr|
        filder_by += "    filter_by :#{attr}, with: :apply_#{attr}\n"
        apply += "    def apply_#{attr}(entity, _attribute, value)
      entity.where('#{@model_data.table_name}.#{attr} LIKE ?', \"%\#{value}%\") if value.present?
    end
"

      end
      "# frozen_string_literal: true

module #{@model_data.model_class}::Finders
  class FindAll < Trailblazer::Finder
    adapters ActiveRecord, Kaminari
    entity { #{@model_data.model_class} }

    paging per_page: 10, min_per_page: 1, max_per_page: 20

#{filder_by}

#{apply}
  end
end
"
    end

  end
end
