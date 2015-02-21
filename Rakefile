desc "Updates and installs"
task :default => :install

desc 'Installs the dot files, replacing your with symlincs to project'
task :install do
  hidden = Dir['.*']
  other_ignored_files = [".", "..", ".gitignore"]
  dot_files = (hidden - git_ignore_files - other_ignored_files).find_all { |f| File.file?(f) }
  dot_files.each do |filename|
    system <<-BASH
      ln -fsv $(pwd)/#{filename} ~/#{filename}
      BASH
  end
end

def git_ignore_files
  git_ignore_expressions = IO.read('.gitignore').split("\n")
  files = [] << git_ignore_expressions.map { | expression | Dir.glob(expression, File::FNM_DOTMATCH) }
  files.flatten
end
