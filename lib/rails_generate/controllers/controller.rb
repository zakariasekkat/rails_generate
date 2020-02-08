require "rails_generate/code_writer"

module RailsGenerate::Controllers
  class Controller < RailsGenerate::CodeWriter

    def initialize(model_data)
      super(model_data)
      @file_path = "app/controllers/#{@model_data.table_name}_controller.rb"
    end

    #index show create update destroy

    def new_file_template_code
      "# frozen_string_literal: true

class AdminsController < ApplicationController
  # GET   /api/#{@model_data.table_name}
  def index
    run #{@model_data.model_class}::Operations::Index, params: params.symbolize_keys do |op|
      page = op[:finder].result
        return render json: {
        data: Admin::AdminUserRepresenter.for_collection.new(page),
        meta: PaginationRepresenter.new(page).to_hash
      }
    end
  end
end
"
    end

  end
end
