class DataGrabberJob < ApplicationJob
  queue_as :default

  def perform(*args)
    parser = ParseService.new
    parser.process

    ActiveRecord::Base.connection.execute 'UPDATE problems AS p SET date_solve = cl.change_date FROM change_logs AS cl WHERE p.status = \'5\' AND p.date_solve IS NULL AND p.id = cl.problem_id AND cl.id = (SELECT id FROM change_logs  WHERE problem_id = p.id AND field=\'status\' AND new=\'5\' ORDER BY change_date DESC LIMIT 1);'
    ActiveRecord::Base.connection.execute 'UPDATE problems AS p SET date_under_control = cl.change_date FROM change_logs AS cl WHERE p.status = \'7\' AND p.date_under_control IS NULL AND p.id = cl.problem_id AND cl.id = (SELECT id FROM change_logs  WHERE problem_id = p.id AND field=\'status\' AND new=\'7\' ORDER BY change_date DESC LIMIT 1);'
  end
end
