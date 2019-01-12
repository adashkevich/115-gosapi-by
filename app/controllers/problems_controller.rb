class ProblemsController < ApplicationController
  before_action :set_status, only: [:index]
  before_action :set_category, only: [:index]
  before_action :set_organization, only: [:index]
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
    problems = filter Problem.limit(100)
    problems = problems.order(crm_create_at: @order_type) if params[:order_by] == 'creating_date'
    if params[:order_by] == 'status_changing'
      problems = problems.joins_last_status.order "cl.change_date #{@order_type}"
    end
    problems
  end

  private

  def filter(query)
    query = query.where(status: @status) if @status
    query = query.where(category_id: @category) if @category
    query = query.where(organisation_id: @organization) if @organization
    query
  end

  def set_status
    @status = params[:filter].blank? ? nil : params[:filter]
  end

  def set_category
    @category = params[:category].blank? ? nil : params[:category]
  end

  def set_organization
    @organization = params[:organization].blank? ? nil : params[:organization]
  end

  def set_order_type
    @order_type = params[:order_type] == 'asc' ? 'ASC' : 'DESC'
  end
end
