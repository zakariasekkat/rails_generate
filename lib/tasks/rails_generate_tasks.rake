require "rails_generate/model"
require "rails_generate/model_data"
require "rails_generate/contracts/create"


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

  end
end

