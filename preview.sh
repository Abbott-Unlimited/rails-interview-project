bundle exec rails db:drop
bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails db:seed
bundle exec rails runner "puts \"\n\nSample API key to use: #{Tenant.all[0].api_key}\n\nThis tenant already has #{Tenant.all[0].calls_today} API calls today.\n\n\n\".green"
bundle exec rails s -b 0.0.0.0
