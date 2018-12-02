class AnswersFixJob < ApplicationJob
  queue_as :default

  def perform(*args)
    parser = ParseService.new
    Problem.where(status: 5, answers_count: 0).each do |problem|
      answers_count = parser.parse_answer problem
      problem.update answers_count: answers_count unless answers_count == 0
    end
  end
end
