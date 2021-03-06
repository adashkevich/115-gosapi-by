# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

set :output, '/opt/gosapi/115-gosapi-by/log/cron_log.log'

every 1.day, at: ['10:00 am', '12:00 am', '2:00 pm', '4:00 pm', '6:00 pm', '10:00 pm'] do
  runner 'DataGrabberJob.perform_now'
end

every 1.day, at: '10:30 pm' do
  runner 'AnswersFixJob.perform_now'
end