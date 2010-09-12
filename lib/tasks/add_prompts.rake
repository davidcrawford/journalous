namespace :db do
  desc "Add prompts to the db"
  task :populate, [:file] => :environment do |t, args|
    prompts = File.open(args.file, "r")
    prompts.each do |line|
      tokens = line.chomp.split('|')
      text = tokens[0]
      quote = tokens[1] if tokens.length > 1
      author = tokens[2] if tokens.length > 2
      Prompt.create!(:text => text, :quote => quote, :quote_author => author)
    end
    prompts.close
  end
end
