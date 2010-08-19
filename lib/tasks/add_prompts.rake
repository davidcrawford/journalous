namespace :db do
  desc "Add prompts to the db"
  task :populate, [:file] => :environment do |t, args|
    prompts = File.open(args.file, "r")
    prompts.each do |line|
      text = line.chomp
      Prompt.create!(:text => text)
    end
    prompts.close
  end
end
