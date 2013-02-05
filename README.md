Description
===
The aim of this project is to show how redis with sinatra can be used

Installation
===
Install ```redis``` and run it (you can read [here](https://github.com/defunkt/resque#installing-redis) about it).
I have Mac Os X and I can do it this way:
```bash
brew install redis
brew info redis                           # to see if all is fine with installation
redis-server /usr/local/etc/redis.conf    # to run redis server
resque-web                                # to run resque standalone front end
```
Prepare your gems and environment by running
```bash
bundle install
rake db:migrate
```

Run
===
To run app execute ```foreman start``` and check [http://localhost:5100](http://localhost:5100)


Tesing
===
Sorry, no tests yet.