# README

# Server  

## Installation
sudo apt-get update  
sudo apt-get install build-essential  
sudo apt-get install git  
sudo apt-get install ruby2.3-dev  
sudo apt-get install lsof  
sudo mkdir /opt/gosapi/115-gosapi-by  
sudo groupadd gosapi-admin  
sudo usermod -a -G gosapi-admin adashkevich  
sudo chown -R adashkevich:gosapi-admin /opt/gosapi  
sudo chmod -R g+rwx /opt/gosapi  
git clone https://github.com/adashkevich/one-one-five-bel.git /opt/gosapi/115-gosapi-by  
sudo groupadd ruby-admin  
sudo usermod -a -G ruby-admin adashkevich  
sudo chown -R :ruby-admin /var/lib/gems/  
sudo chmod -R g+rwx /var/lib/gems/  
(optional) sudo apt-get install libpq-dev  
(optional) sudo apt-get install zlib1g-dev  
cd /opt/gosapi/115-gosapi-by  
gem install bundler  
sudo vi /etc/profile.d/115-gosapi-by.sh (then press :esc :wq to save and exit)  
sudo chmod ug+x /opt/gosapi/115-gosapi-by/bin/startup  
sudo chmod ug+x /opt/gosapi/115-gosapi-by/bin/shutdown  

sudo chown adashkevich:gosapi-admin /etc/profile.d/gosapi-by.sh
sudo chown adashkevich:gosapi-admin /etc/profile.d/115-gosapi-by.sh  
sudo chown adashkevich:gosapi-admin /etc/profile.d/map-gosapi-by.sh  
sudo chmod g+rw /etc/profile.d/gosapi-by.sh  
sudo chmod g+rw /etc/profile.d/115-gosapi-by.sh  
sudo chmod g+rw /etc/profile.d/map-gosapi-by.sh  

sudo dpkg-reconfigure tzdata

## Life circle
To start up server execute `bin/startup` script. (`./bin/startup`)  
To shut down server execute `bin/shutdown` script. (`./bin/shutdown`)  
#Data Base
##Preparation
1. Add postgis extension
`CREATE EXTENSION postgis;`
## Dumping
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

## Cron jobs
gem install whenever  
whenever --update-crontab  

## 3D Party Libraries
[Select Component](https://developer.snapappointments.com/bootstrap-select)  
[Corn Planer](https://github.com/javan/whenever)  
