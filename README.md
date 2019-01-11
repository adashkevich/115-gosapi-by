# README

#Server  

##Installation
sudo apt-get install build-essential  
sudo apt-get install git  
sudo apt-get install ruby  
sudo mkdir /opt/gosapi  
git clone https://github.com/adashkevich/one-one-five-bel.git /opt/gosapi  
sudo groupadd 115-bel-admin  
sudo usermod -a -G 115-bel-admin andrew.daskhevich  
sudo chown -R root:ruby-admin /opt/gosapi
sudo groupadd ruby-admin  
sudo usermod -a -G ruby-admin andrew.daskhevich  
sudo chown -R root:ruby-admin /var/lib/gems  
sudo chmod -R g+rwx /var/lib/gems  
(optional) sudo apt-get install libpq-dev
(optional) sudo apt-get install zlib1g-dev  
gem install bundler


##Life circle
To start up server execute `startup.sh` script. (`./startup.sh`)  
To shut down server execute `shutdown.sh` script. (`./shutdown.sh`) 
#Data Base
##Preparation
1. Add postgis extension
`CREATE EXTENSION postgis;`
##Dumping
Model dump rake task:
`rake db:seed:dump MODELS=model FILE=db/seeds/model.rb EXCLUDE=none`

Category params:
`MODELS=Category FILE=db/seeds/categories.rb EXCLUDE=none`

Organization params:
`MODELS=Organization FILE=db/seeds/organizations.rb EXCLUDE=created_at,updated_at`

City params:
`MODELS=City FILE=db/seeds/cities.rb EXCLUDE=created_at,updated_at`

Status params:
`MODELS=Status FILE=db/seeds/statuses.rb EXCLUDE=none`