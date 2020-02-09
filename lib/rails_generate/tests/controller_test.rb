require "rails_generate/code_writer"

module RailsGenerate::Tests
  class ControllerTest < RailsGenerate::CodeWriter

    def initialize(model_data)
      super(model_data)
      @file_path = "test/integration/#{@model_data.table_name}_controller_test.rb"
    end


    def new_file_template_code
      "# frozen_string_literal: true

require 'test_helper'

class #{@model_data.table_name.capitalize}ControllerTest < ActionDispatch::IntegrationTest

  it 'should get #{@model_data.table_name}' do
    Fabricate(:#{@model_data.model_file})
    get '/api/#{@model_data.table_name}'
    assert_response :success
    assert_equal 1, response.parsed_body['data'].count
  end

  it 'should get a #{@model_data.model_file}' do
    #{@model_data.model_file} = Fabricate(:#{@model_data.model_file})
    get \"/api/#{@model_data.table_name}/\#{person.id}\"
    assert_response :success
    assert_equal #{@model_data.model_file}.id, response.parsed_body['id']
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
