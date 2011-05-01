
namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do

    Rake::Task['db:reset'].invoke
    
    99.times do |n|
      Contract.create!(    
      :title => "Contrato construcción torre agua", 
      :description => "Contrato construcción torre agua", 
      :contract_type=> "Construcciones", 
      :procedure=> "Procedimiento", 
      :budget_announced=> "20.000", 
      :budget_adjudicated=> "30.000", 
      :idweb =>nil, 
      :company_name=> "Empresa de pepe", 
      :department=> "Depart", 
      :signed_by=> "Juan Sierra", 
      :resolution_date=> "12/1/2002")      
    end
  end
end