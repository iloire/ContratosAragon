# encoding: UTF-8
require 'rubygems'
require 'open-uri'
require 'hpricot'
require 'sqlite3'
require 'iconv'

#where all the raw html files fetched are located
@input_path = "/Users/ivanloire/dev/rails/ContratosPublicos/rawData"

#where the filtered (just the final contracts) and resumed html files (just the part we need) will be placed
@output_path="/Users/ivanloire/dev/rails/ContratosPublicos/rawDataDefinitivos/"

def SaveResponse (id, response)
   File.open(@output_path + id.to_s + ".html", 'w') do |f|
      f.puts response
   end
end

def get_file_as_string(filename)
  data = ''
  f = File.open(filename, "r:WINDOWS-1252") 
  f.each_line do |line|
    data += line
  end
#  puts data
  return data
end



#main
dir = @input_path
Dir.glob("#{dir}/**/**").each {
  |f| 

counter=0
begin
   id=File.basename(f).rjust(6,'0')   
   
   fileContent=get_file_as_string(f)
   #ic = Iconv.new('UTF-8', 'WINDOWS-1252')
   ic = Iconv.new('UTF-8', 'ISO-8859-1')
   fileContent = ic.iconv(fileContent + ' ')[0..-2]  

   #as read somewhere, to make sure there is not invalid utf chars in the string
   #ic=Iconv.new('utf-8', 'utf-8')
   #fileContent = ic.iconv(fileContent + ' ')[0..-2]     
   
   doc = Hpricot(fileContent) 

   textoAdjudicacion=(doc/"//*[@id=\"label0\"]").inner_text
   #es_provisional=textoAdjudicacion.include? "Anuncio de adjudicación provisional de contrato"
   es_definitiva=textoAdjudicacion.include? "Anuncio de adjudicación definitiva de contrato"
   
   response=(doc/"html/body/div[4]").inner_html

   if (es_definitiva)
     SaveResponse(id,response) 
     puts "saving contract #{id}"
   else
     puts "skip contract  #{id}"
   end
   counter=counter + 1
  rescue=>e
    puts "Error: #{e}"
    break 
  end
}
puts "#{counter} files processed from #{dir}"

