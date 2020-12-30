module Timeable
  extend ActiveSupport::Concern

  class_methods do
    def between(range:, field: 'created_at')
      where(field.to_sym => range.start_time..range.end_time)
    end
  end
end
