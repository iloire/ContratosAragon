# encoding: UTF-8
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


def maxlen(str)
  if (str.size>255)
    str=str[0,250] + "..."
  end
  str
end


debug =false

namespace :db do
  desc "Fill database with sample data"
  task :populateFromFiles => :environment do
    
    Rake::Task['db:reset'].invoke
      counter=0  
    dir = "/Users/ivanloire/dev/rails/ContratosPublicos/rawDataSmall/formalizacion"
    Dir.glob("#{dir}/**/**").each {
      |f|       
        id=File.basename(f).rjust(6,'0')   
        puts "procesando #{id}.... (#{counter})"
        counter=counter+1                
        if (debug)
          if counter>3
            break #uncomment to break on 100 records
          end        

        end
                 
         begin                  
         
         fileContent=get_file_as_string(f)
         ic = Iconv.new('UTF-8', 'WINDOWS-1252')
         fileContent = ic.iconv(fileContent + ' ')[0..-2]  

         doc = Hpricot(fileContent)

         #titulo
         titulo=(doc/"/div[2]/fieldset/div[3]/div/div[2]/div").inner_text
         titulo=maxlen(titulo)
         
         #empresa
         empresa=doc.at("//label[text()*='Contratista:']").parent.parent.children[3].children[1].inner_text
         empresa=maxlen(empresa)
         
         #procedimiento
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

         #tipo contrato
         tipocontrato=doc.at("//label[text()*='Tipo de contrato:']").parent.parent.children[3].children[1].inner_text
         tipocontrato=maxlen(tipocontrato)
         
         #organismo
         organismo=doc.at("//label[text()*='Organismo:']").parent.parent.children[3].children[1].inner_text        
         organismo=maxlen(organismo)
         
         #firmado por
         firmado= (doc/"/div[2]/div[2]/div[1]/ul/li[1]/span[2]").inner_html
         firmado=maxlen(firmado)

         #pub
         fechapublicacionanuncio=doc.at("//label[text()*='Fecha de Publicación del anuncio:']").parent.parent.children[3].children[1].inner_text
        
         #presupuestos  
         presupuestoBase=doc.at("//label[text()*='Presupuesto base de licitación']").parent.parent.children[3].children[1].inner_text   
         presupuestoAdj=doc.at("//label[text()*='Importe de adjudicación']").parent.parent.children[3].children[1].inner_text   
         
         
         Contract.create!(    
          :title => titulo, 
          :description => "desc", 
          :contract_type=> tipocontrato, 
          :procedure=> proced, 
          :budget_announced=> presupuestoBase, 
          :budget_adjudicated=> presupuestoAdj, 
          :idweb => id=File.basename(f)  , 
          :company_name=> empresa, 
          :department=> organismo, 
          :signed_by=> firmado, 
          :resolution_date=> fechapublicacionanuncio)

        rescue =>e
          puts "Error en id: #{id}. Error: #{e}"
          #break
        end
    }
      
  end
end