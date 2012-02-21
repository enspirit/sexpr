def clean_file(file)
  c = File.read(file)
  c.gsub!(/[ \t]+\n/, "\n")
  c.gsub!(/\n\Z/, '')
  File.open(file, 'w'){|io|
    io << c
  }
end

Dir["**/*.rb"].each{|file| clean_file(file)}
Dir["**/*.gis"].each{|file| clean_file(file)}