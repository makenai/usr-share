raw_config = File.read("#{Rails.root}/config/app_config.yml") rescue nil
APP_CONFIG = ( raw_config ? YAML.load(raw_config)[Rails.env] : {} ).merge(ENV).symbolize_keys