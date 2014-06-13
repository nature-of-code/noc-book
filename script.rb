require 'asciidoctor'

folder = "./raw"

Dir.foreach(folder) do |file|
  if File.extname(file) == ".asc"
    template_dir = "/Users/runemadsen/Projects/OReilly/orm-atlas-cookbooks/repositories/asciidoctor-htmlbook/htmlbook"
    file_content = File.open("#{folder}/#{file}").read
    base_dir = File.dirname("#{folder}/#{file}")
    content = Asciidoctor.render(file_content, :safe => :safe, :in_place => true, :base_dir => base_dir, :template_dir => template_dir)
    File.open("#{folder}/#{File.basename(file, ".asc")}.html", 'w') {|f| f.write(content) }
  end
end