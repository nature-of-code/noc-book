require 'asciidoctor'

folder = "./raw"

Dir.foreach(folder) do |file|
  if File.extname(file) == ".asc"
    Asciidoctor.render_file("#{folder}/#{file}", 
      :safe => :safe,
      :header_footer => false,
      :in_place => true,
      :template_dir => "/Users/runemadsen/Projects/OReilly/orm-atlas-cookbooks/repositories/asciidoctor-htmlbook/htmlbook"
    )
  end
end