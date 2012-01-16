Resque.redis = Redis.new  Rails.env.production? ? ENV['REDISTOGO_URL'] : 'http://localhost:6379'

Resque.schedule = YAML.load_file(File.join(File.dirname(__FILE__), '../resque_schedule.yml'))

Resque.after_fork = Proc.new { ActiveRecord::Base.establish_connection }