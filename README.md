# README

To start app:
install ruby

##Dumping
Dump current data base:
`rake db:seed:dump MODELS=model FILE=db/seeds/model.rb EXCLUDE=none`

Category params:
`MODELS=Category FILE=db/seeds/categories.rb EXCLUDE=none`

Organization params:
`MODELS=Organization FILE=db/seeds/organizations.rb EXCLUDE=created_at,updated_at`

City params:
`MODELS=City FILE=db/seeds/cities.rb EXCLUDE=created_at,updated_at`

Status params:
`MODELS=Status FILE=db/seeds/statuses.rb EXCLUDE=none`