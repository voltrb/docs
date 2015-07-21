Dir.glob('en/**/*.md') do |file|
  open(file, 'a') do |f| 
    f << "\nModified at {{ file.mtime }}\n"
  end
end

Dir.glob('ja/**/*.md') do |file|
  open(file, 'a') do |f|
    f << "\nで修正されましたt {{ file.mtime }}\n"
  end
end

