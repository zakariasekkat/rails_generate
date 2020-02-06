require "rails_generate/model"

desc "Explaining what the task does"
task :rails_generate_from_table do
  ARGV.each { |a| task a.to_sym }

  if ARGV[1].blank?
    puts "you have to send table name as first param"
    exit
  end

  table_name = ARGV[1]
  model_file = table_name.singularize
  model_class = model_file.slice(0, 1).capitalize + model_file.slice(1..-1)

  puts "#{table_name} #{model_file} #{model_class}"

  RailsGenerate::Model.new.toto

end
