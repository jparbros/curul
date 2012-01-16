web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb
worker: bundle exec rake resque:work QUEUE=*
scheduler: bundle exec rake resque:scheduler