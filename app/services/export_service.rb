class ExportService
  def self.export_borders
    sql = "SELECT p.id             as problem_id,
             p.href           as problem_href,
             a.text           as problem_answer,
             u.name || ' ' || u.last_name as submitter_name,
             ST_X(p.location::geometry) AS lng,
             ST_Y(p.location::geometry) AS lat,
             p.status         as problem_status
          FROM problems AS p
                 LEFT JOIN answers AS a ON a.problem_id = p.id AND a.is_organization = true
                 JOIN users AS u ON u.id = p.user_id
          WHERE p.category_id = 294 AND p.id NOT IN (SELECT problem_id FROM map_imports);"

    ActiveRecord::Base.connection.select_all(sql).to_hash.each do |export_item|
      item = MapItem.create export_item.merge(item_type: 'border', processed: false)
      Photo.where(problem_id: export_item['problem_id']).each do |photo|
        MapPhoto.create url: 'http://115.xn--90ais' + photo.src, name: File.basename(photo.src), size: 0, original_id: photo.id, system: '115-bel', item_id: item.id
      end
      MapImport.create problem_id: export_item['problem_id']
    end
  end

  def self.export_photo
    MapItem.where(processed: false).where.not(problem_id: nil).each do |item|
      Photo.where(problem_id: item.problem_id).each do |photo|
        MapPhoto.create url: 'http://115.xn--90ais' + photo.src, name: File.basename(photo.src), size: 0, original_id: photo.id, system: '115-bel', item_id: item.id
      end
    end
  end
end