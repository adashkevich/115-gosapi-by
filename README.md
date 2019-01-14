# README

#Server  

##Installation
sudo apt-get install build-essential  
sudo apt-get install git  
sudo apt-get install ruby  
sudo apt-get install lsof  
sudo mkdir /opt/gosapi/one-one-five-bel  
sudo groupadd 115-bel-admin  
sudo usermod -a -G 115-bel-admin andrew.daskhevich  
git clone https://github.com/adashkevich/one-one-five-bel.git /opt/gosapi/one-one-five-bel  
sudo chmod -R g+rwx /opt/gosapi/one-one-five-bel  
sudo chown -R root:ruby-admin /opt/gosapi
sudo groupadd ruby-admin  
sudo usermod -a -G ruby-admin andrew.daskhevich  
sudo chown -R root:ruby-admin /var/lib/gems  
sudo chmod -R g+rwx /var/lib/gems  
(optional) sudo apt-get install libpq-dev
(optional) sudo apt-get install zlib1g-dev  
gem install bundler  
sudo vi /etc/profile.d/115-gosapi-by.sh (then press :esc :wq to save and exit)  
sudo chown -R root:115-bel-admin /etc/profile.d/115-gosapi-by.sh  
sudo chmod -R g+rw /etc/profile.d/115-gosapi-by.sh  
sudo dpkg-reconfigure tzdata

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

##Ruby Scripts
Category.where.not(parent_id: nil).order(:parent_id).each { |cat|  p "<option value=\"#{cat.id}\">#{cat.title}</option>"}  
Category.where(parent_id: nil).order(:id).each { |cat|  p "<optgroup label=\"#{cat.title}\">"}  

##3D Party Libraries
[Select Component](https://developer.snapappointments.com/bootstrap-select)  
[Corn Planer](https://github.com/javan/whenever)  