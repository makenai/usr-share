raw_config = File.read("#{Rails.root}/config/app_config.yml") rescue {}
APP_CONFIG = YAML.load(raw_config)[Rails.env].merge(ENV).symbolize_keys