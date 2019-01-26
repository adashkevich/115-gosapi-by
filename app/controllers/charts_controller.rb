require 'csv'

class ChartsController < ApplicationController

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
