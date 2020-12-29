CHUNK_SIZE = 1000
module DatabaseHelper

  def import_records(model_name: , records:, recursive: false)
    model = model_name.constantize
    begin
      model.import! records
    rescue ActiveRecord::RecordInvalid => e
      puts "Inserting valid values only since #{e}"
      model.import records
    rescue ActiveRecord::RecordNotUnique => e
      puts "Ignoring as record is already present"
    end
  end

end
