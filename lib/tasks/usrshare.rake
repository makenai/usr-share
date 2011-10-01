namespace :usrshare do

  desc "Pick a random user as the winner"
  task :update_sample_config => :environment do
    config = YAML.load_file( Rails.root.join('config', 'app_config.yml') )
    config.each do |env,vars|
      vars.each do |key,value|
        vars[key] = ''
      end
    end
    File.open( Rails.root.join('config', 'app_config.yml.sample'), 'w' ) do |sample|
      sample.write( YAML.dump(config) )
    end
  end
  
  desc "Update heroku configuration"
  task :update_heroku_config => :environment do
    # Taken from http://trevorturk.com/2009/06/25/config-vars-and-heroku/
    puts "Reading config/config.yml and sending config vars to Heroku..."
    CONFIG = YAML.load_file('config/app_config.yml')['production'] rescue {}
    command = "heroku config:add"
    CONFIG.each {|key, val| command << " #{key}=#{val} " if val }
    system command
  end

end