# encoding: ISO-8859-1
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


def maxlen(str, len)
  if (str.size>len)
    str=str[0,len] + "..."
  end
  str
end


debug =false
maxsize=200

namespace :db do
  desc "Fill database with sample data"
  task :populateFromFiles => :environment do
    
    Rake::Task['db:reset'].invoke
      counter=0  
    dir = "/Users/ivanloire/dev/rails/ContratosPublicos/rawDataPreParsed"
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
         success=true #record successfully parsed?
         
         fileContent=get_file_as_string(f)
         #puts fileContent
         #break
         #ic = Iconv.new('UTF-8', 'WINDOWS-1252')
         #ic = Iconv.new('UTF-8', 'ISO-8859-1')
         #fileContent = ic.iconv(fileContent + ' ')[0..-2]  

         #as read somewhere, to make sure there is not invalid utf chars in the string
         #ic=Iconv.new('utf-8', 'utf-8')
         #fileContent = ic.iconv(fileContent + ' ')[0..-2]  

         #just for ruby 1.9
		     #fileContent=fileContent.encode("UTF-8", undef: :replace, replace: "??") 
		     
         doc = Hpricot(fileContent)

         textoAdjudicacion=(doc/"//*[@id=\"label0\"]").inner_text
         es_provisional=textoAdjudicacion.include? "Anuncio de adjudicación provisional de contrato"
         es_definitiva=textoAdjudicacion.include? "Anuncio de adjudicación definitiva de contrato"
         #puts textoAdjudicacion
         #break

         if (es_definitiva)
           #titulo
           titulo=(doc/"/div[2]/fieldset/div[3]/div/div[2]/div").inner_text
           titulo=maxlen(titulo,maxsize)

           #empresa
           empresa=doc.at("//label[text()*='Contratista:']").parent.parent.children[3].children[1].inner_text
           empresa=maxlen(empresa, maxsize)

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
           tipocontrato=maxlen(tipocontrato,maxsize)

           #organismo
           organismo=doc.at("//label[text()*='Organismo:']").parent.parent.children[3].children[1].inner_text        
           organismo=maxlen(organismo,maxsize)

           #firmado por
           firmado= (doc/"/div[2]/div[2]/div[1]/ul/li[1]/span[2]").inner_html
           firmado=maxlen(firmado,maxsize)

           #pub
           fechapublicacionanuncio=doc.at("//label[text()*='Fecha de Publicación del anuncio:']").parent.parent.children[3].children[1].inner_text
           if (fechapublicacionanuncio.size>50)
             success=false
           end
           fechapublicacionanuncio=maxlen(fechapublicacionanuncio,maxsize)
           fecharesolucion=doc.at("//label[text()*='Resolución']").parent.parent.children[3].children[1].inner_text
           puts fecharesolucion

           #presupuestos  
           presupuestoBase=doc.at("//label[text()*='Presupuesto base de licitación']").parent.parent.children[3].children[1].inner_text            
           presupuestoBase=maxlen(presupuestoBase,maxsize)

           presupuestoAdj=doc.at("//label[text()*='Importe de adjudicación']").parent.parent.children[3].children[1].inner_text   
           presupuestoAdj=maxlen(presupuestoAdj,maxsize)

           Contract.create!(    
           :title => titulo, 
           :success=> success,
           :description => "desc", 
           :contract_type=> tipocontrato, 
           :procedure=> proced, 
           :budget_announced=> presupuestoBase, 
           :budget_adjudicated=> presupuestoAdj, 
           :idweb => id=File.basename(f)  , 
           :company_name=> empresa, 
           :department=> organismo, 
           :signed_by=> firmado, 
           :resolution_date=> fecharesolucion)
           
            puts "   definitiva #{id}!"
        else
            puts "   provisional #{id}"
        end    
        rescue =>e
          puts "Error en id: #{id}. Error: #{e}"
          #break
        end
    }
      
  end
end