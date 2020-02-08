require "rails_generate/code_writer"

module RailsGenerate::Controllers
  class Controller < RailsGenerate::CodeWriter

    def initialize(model_data)
      super(model_data)
      @file_path = "app/controllers/#{@model_data.table_name}_controller.rb"
    end


    def new_file_template_code
      "# frozen_string_literal: true

class #{@model_data.table_name.capitalize}Controller < ApplicationController
  # GET  /api/#{@model_data.table_name}
  def index
    run #{@model_data.model_class}::Operations::Index, params: params.symbolize_keys do |op|
      page = op[:finder].result
        return render json: {
        data: #{@model_data.model_class}Representer.for_collection.new(page),
        meta: PaginationRepresenter.new(page).to_hash
      }
    end
  end

  # GET  /api/#{@model_data.table_name}/:id
  def show
    run #{@model_data.model_class}::Operations::Show do
      return render json: #{@model_data.model_class}Representer.new(@model)
    end
    render nothing: true, status: :not_found
  end

  # POST  /api/#{@model_data.table_name}
  def create
    run #{@model_data.model_class}::Operations::Create do
      return render json: #{@model_data.model_class}Representer.new(@model), status: :created
    end
    render json: @form.errors.messages, status: :unprocessable_entity
  end

  # PATCH  /api/#{@model_data.table_name}/:id
  def update
    run #{@model_data.model_class}::Operations::Update do
      return render json: #{@model_data.model_class}Representer.new(@model)
    end
    render nothing: true, status: :unprocessable_entity
  end

  # DELETE /api/#{@model_data.table_name}/:id
  def destroy
    run #{@model_data.model_class}::Operations::Destroy do
      return render json: true
    end
    render nothing: true, status: :unprocessable_entity
  end

end
"
    end

  end
end
