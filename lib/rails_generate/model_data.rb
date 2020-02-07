module RailsGenerate
  class ModelData

    attr_reader :table_name,
                :model_file,
                :model_class,
                :table_fields,
                :attributes

    def initialize(table_name)
      @table_name = table_name
      @model_file = table_name.singularize
      @model_class = model_file.slice(0, 1).capitalize + model_file.slice(1..-1)
      @table_fields = ActiveRecord::Base.connection.execute("select * from #{@table_name} limit 1").fields
      @attributes = @table_fields - ["id", "created_at", "updated_at"]
    end

  end
end
