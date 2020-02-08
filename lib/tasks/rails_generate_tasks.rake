require "rails_generate/model"
require "rails_generate/model_data"
require "rails_generate/contracts/create"
require "rails_generate/contracts/update"
require "rails_generate/operations/create"
require "rails_generate/operations/show"
require "rails_generate/operations/update"
require "rails_generate/operations/destroy"
require "rails_generate/finders/find_all"
require "rails_generate/operations/index"
require "rails_generate/router"

namespace :rails_generate do

  desc "Explaining what the task does"
  task from_table: :environment do
    ARGV.each { |a| task a.to_sym }

    if ARGV[1].blank?
      puts "you have to send table name as first param"
      exit
    end

    model_data = RailsGenerate::ModelData.new(ARGV[1])

    RailsGenerate::Model.new(model_data).generate
    RailsGenerate::Contracts::Create.new(model_data).generate
    RailsGenerate::Contracts::Update.new(model_data).generate
    RailsGenerate::Operations::Create.new(model_data).generate
    RailsGenerate::Operations::Show.new(model_data).generate
    RailsGenerate::Operations::Update.new(model_data).generate
    RailsGenerate::Operations::Destroy.new(model_data).generate
    RailsGenerate::Finders::FindAll.new(model_data).generate
    RailsGenerate::Operations::Index.new(model_data).generate
    RailsGenerate::Router.new(model_data).generate

  end
end

