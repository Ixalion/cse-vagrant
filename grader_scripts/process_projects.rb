#!/usr/bin/env ruby

gem 'rubyzip', '~> 1.2'

require 'zip'

def eclipse_project_file(name)
<<-EOF
<?xml version="1.0" encoding="UTF-8"?>
<projectDescription>
	<name>#{name}</name>
	<comment></comment>
	<projects>
	</projects>
	<buildSpec>
		<buildCommand>
			<name>org.eclipse.jdt.core.javabuilder</name>
			<arguments>
			</arguments>
		</buildCommand>
		<buildCommand>
			<name>net.sf.eclipsecs.core.CheckstyleBuilder</name>
			<arguments>
			</arguments>
		</buildCommand>
		<buildCommand>
			<name>edu.umd.cs.findbugs.plugin.eclipse.findbugsBuilder</name>
			<arguments>
			</arguments>
		</buildCommand>
	</buildSpec>
	<natures>
		<nature>org.eclipse.jdt.core.javanature</nature>
		<nature>net.sf.eclipsecs.core.CheckstyleNature</nature>
		<nature>edu.umd.cs.findbugs.plugin.eclipse.findbugsNature</nature>
	</natures>
</projectDescription>
EOF
end
# Create a helper for unzipping archives.
# Obtained from: http://stackoverflow.com/a/37195592/1658810
def extract_zip(file, destination)
  FileUtils.mkdir_p(destination)

  Zip::File.open(file) do |zip_file|
    zip_file.each do |f|
      fpath = File.join(destination, f.name)
      zip_file.extract(f, fpath) unless File.exist?(fpath)
    end
  end
end

# Extract the projects
puts "Extracting submissions.zip into projectsRaw"
extract_zip("submissions.zip", "projectsRaw");

# Rename the projects to match the correct name#
puts "Renaming submissions to 'name.#.zip', and moving them to ./projectsGood/"
FileUtils.mkdir_p("./projectsGood")
Dir["./projectsRaw/*.zip"].each do |filepath|
  filename = File.basename(filepath, ".zip");
  filename.gsub!(/.*?(?=_)/im, "")
  filename.gsub!("_","");
  filename.gsub!(/-[^\s]+/,"");
  filename.downcase!

  FileUtils.mkdir_p("./projectsGood/#{filename}")
  filenameZip = "./projectsGood/#{filename}/#{filename}.zip"

  FileUtils.cp(filepath, filenameZip)

  puts "Unzipping #{filename}"
  system("(cd \"./projectsGood/#{filename}\"; unzip '*.zip')")
  FileUtils.rm(filenameZip)

  puts "Updating .project"
  index = 0
  Dir["./projectsGood/#{filename}/**/.project"].each do |projectFile|
    open(projectFile, 'w') do |file|
      if index == 0
        file << eclipse_project_file(filename)
      else
        file << eclipse_project_file("#{filename}_#{index}")
      end
      index += 1
    end
  end
end

# Going to copy the test files into the projects
Dir.glob("./projectsGood/**/test/").each do |path|
  FileUtils.cp(Dir.glob("./TestFiles/*.java"), path)
end


# Cleanup now
puts "Going to cleanup some now"
FileUtils.rm_r("./projectsRaw")
