require 'csv'

class ChartsController < ApplicationController

  def problems_count_per_day
    results = ActiveRecord::Base.connection.execute 'SELECT COUNT(*), s.title, p.crm_create_at FROM problems AS p JOIN statuses AS s ON s.id=p.status::int GROUP BY p.status, p.crm_create_at, s.title ORDER BY crm_create_at, status;'
    render json: results.to_json
  end

  def problems_by_organization
    results = ActiveRecord::Base.connection.execute 'SELECT COUNT(*) AS all, o.name FROM problems AS p JOIN organizations AS o ON o.id=p.organisation_id::int GROUP BY o.name ORDER BY COUNT(*) DESC;'

    respond_to do |format|
      format.json { render json: results }
      format.csv { render inline: to_csv(results) }
    end
  end

  def unsolved_problems_by_organization
    results = ActiveRecord::Base.connection.execute 'SELECT COUNT(*) AS unsolved, o.name FROM problems AS p JOIN organizations AS o ON o.id=p.organisation_id::int WHERE p.status!=\'5\' GROUP BY o.name ORDER BY COUNT(*) DESC;'

    respond_to do |format|
      format.json { render json: results }
      format.csv { render inline: to_csv(results) }
    end
  end

  def problems_by_category
    results = ActiveRecord::Base.connection.execute 'SELECT COUNT(*) AS all, c.id, c.title AS category FROM problems AS p INNER JOIN categories AS c ON c.id = p.category_id GROUP BY p.category_id, c.id, c.title ORDER BY COUNT(*) DESC LIMIT 15;'

    respond_to do |format|
      format.json { render json: results }
      format.csv { render inline: to_csv(results) }
    end
  end

  def unsolved_problems_by_category
    results = ActiveRecord::Base.connection.execute 'SELECT COUNT(*) AS unsolved, c.id, c.title AS category FROM problems AS p INNER JOIN categories AS c ON c.id = p.category_id WHERE p.status!=\'5\' GROUP BY p.category_id, c.id, c.title ORDER BY COUNT(*) DESC  LIMIT 15;'

    respond_to do |format|
      format.json { render json: results }
      format.csv { render inline: to_csv(results) }
    end
  end

  def new_problems_per_day
    results = ActiveRecord::Base.connection.execute 'SELECT COUNT(*), crm_create_at FROM problems GROUP BY crm_create_at ORDER BY crm_create_at;'

    respond_to do |format|
      format.json { render json: results }
      format.csv { render inline: to_csv(results) }
    end
  end
  # results = ActiveRecord::Base.connection.execute
  # render json: results.to_json

  def problems
    results = ActiveRecord::Base.connection.execute 'SELECT * FROM problems;'

    respond_to do |format|
      format.json { render json: results }
      format.csv { render inline: to_csv(results) }
    end
  end

  def users
    results = ActiveRecord::Base.connection.execute 'SELECT * FROM users;'

    respond_to do |format|
      format.json { render json: results }
      format.csv { render inline: to_csv(results) }
    end
  end

  def organizations
    results = ActiveRecord::Base.connection.execute 'SELECT * FROM organizations;'

    respond_to do |format|
      format.json { render json: results }
      format.csv { render inline: to_csv(results) }
    end
  end

  def categories
    results = ActiveRecord::Base.connection.execute 'SELECT * FROM categories;'

    respond_to do |format|
      format.json { render json: results }
      format.csv { render inline: to_csv(results) }
    end
  end

  private

  def to_csv(records)
    CSV.generate do |csv|
      csv << records.fields
      records.each_row do |record|
        csv << record
      end
    end
  end
end
