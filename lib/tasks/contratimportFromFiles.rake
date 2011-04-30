require 'faker'
require 'hpricot'


#helper methods
def get_file_as_string(filename)
  data = ''
  f = File.open(filename, "r:UTF-8") 
  f.each_line do |line|
    data += line
  end
#  puts data
  return data
end






namespace :db do
  desc "Fill database with sample data"
  task :populateFromFiles => :environment do

    Rake::Task['db:reset'].invoke
      counter=0  
    dir = "/Users/ivanloire/dev/rails/ContratosPublicos/rawData/original"
    Dir.glob("#{dir}/**/**").each {
      |f| 
      
        counter=counter+1
        
        if counter>100
          break
        end
        
         #puts "contrato nulo, salvamos #{f}"
                  
         fileContent=get_file_as_string(f)
         ic = Iconv.new('UTF-8', 'WINDOWS-1252')
         fileContent = ic.iconv(fileContent + ' ')[0..-2]  

         doc = Hpricot(fileContent)
         titulo=(doc/"/html/body/div[4]/div[2]/fieldset/div[3]/div/div[2]/div").inner_text
         empresa=doc.at("//label[text()*='Contratista:']").parent.parent.children[3].children[1].inner_text
         
         proced=doc.at("//label[text()*='Procedimiento:']").parent.parent.children[3].children[1].inner_text      
         if proced.downcase.include? "abierto"
           proced="Abierto"
         elsif proced.downcase.include? "negociado"
           proced="Negociado"
         elsif proced.downcase.include? "abreviado"
           proced="Abreviado"
         else
           proced="Otros"
         end

         
         tipocontrato=doc.at("//label[text()*='Tipo de contrato:']").parent.parent.children[3].children[1].inner_text
         organismo=doc.at("//label[text()*='Organismo:']").parent.parent.children[3].children[1].inner_text        
        
         Contract.create!(    
          :title => titulo, 
          :description => "Contrato construcción torre agua", 
          :contract_type=> tipocontrato, 
          :procedure=> proced, 
          :budget_announced=> "20.000", 
          :budget_adjudicated=> "30.000", 
          :idweb =>nil, 
          :company_name=> empresa, 
          :department=> organismo, 
          :signed_by=> "Juan Sierra", 
          :resolution_date=> "12/1/2002")
    }
      
  end
end