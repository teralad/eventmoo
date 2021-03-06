CHUNK_SIZE = 1000
module DatabaseHelper

  def import_records(model_name: , records:, recursive: false)
    model = model_name.constantize
    begin
      # Active record import supports recursive only for postgres
      if recursive
        records.each do |record|
          record.save!
        end
      else
        model.import! records
      end
    rescue ActiveRecord::RecordInvalid => e
      puts "Inserting valid values only since #{e}"
      model.import records
    rescue ActiveRecord::RecordNotUnique => e
      puts "Ignoring as record is already present"
    end
  end

end
