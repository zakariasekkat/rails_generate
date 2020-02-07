require "rails_generate/model"
require "rails_generate/model_data"


desc "Explaining what the task does"
task rails_generate_from_table: :environment do
  ARGV.each { |a| task a.to_sym }

  if ARGV[1].blank?
    puts "you have to send table name as first param"
    exit
  end

  RailsGenerate::Model.new(
    RailsGenerate::ModelData.new(ARGV[1])
  ).generate


end
