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

end