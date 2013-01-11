#!/usr/bin/env ruby

require 'find'
require 'fileutils'
FIXTURES_DIRECTORY=File.expand_path(File.join(File.dirname(__FILE__), "objects"))
CORPUS_DIRECTORY=File.expand_path(File.join(File.dirname(__FILE__), "openplanets-format-corpus"))


Find.find(CORPUS_DIRECTORY) do |path|
  next unless FileTest.directory? path
  next if path =~ /tools/ or path =~ /filesys/

  base = "op_" + path.split("/").last.gsub(/[^A-Za-z0-9_-]/, '_')
  fixture_directory = File.join(FIXTURES_DIRECTORY,base)
  

  Dir.chdir(path) do 
    Dir.glob('*').select { |x| FileTest.file? x }.each do |f|
      FileUtils.mkdir(fixture_directory) unless FileTest.directory? fixture_directory

      FileUtils.cp f, fixture_directory
    end
  end

end

Dir.glob(File.join(FIXTURES_DIRECTORY, "op_*")) do |fixture_directory|

  `/usr/local/share/python/bagit.py --contact-name 'Chris Beer' #{fixture_directory}`

end