every 1.day, at: '11:00 pm' do
  runner 'DataGrabberJob.perform_now'
end