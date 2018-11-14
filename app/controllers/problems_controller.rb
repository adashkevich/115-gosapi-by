class ProblemsController < ApplicationController
  before_action :set_filter, only: [:index]
  before_action :set_order_type, only: [:index]

  def index
    problems = get_problems
    answers = get_answers problems

    render json: { problems: problems, answers: answers}
  end

  private

  def get_answers(problems)
    problem_ids = problems.map(&:id)
    Answer.where(problem_id: problem_ids).order(:publish_date).group_by(&:problem_id)
  end

  def get_problems
    problems = Problem.where(status: @filter).limit(100)
    problems = problems.order(crm_create_at: @order_type) if params[:order_by] == 'creating_date'
    if params[:order_by] == 'status_changing'
      problems = problems.joins_last_status.order 'change_logs.change_date DESC'
    end
    problems
  end

  def set_filter
    @filter = []
    params[:filter].each do |filter_str|
      case filter_str
      when 'resolved'
        @filter << '5'
      when 'under_control'
        @filter << '7'
      when 'in_work'
        @filter << '4'
      end
    end
  end

  def set_order_type
    @order_type = params[:order_type] == 'asc' ? :asc : :desc
  end
end
