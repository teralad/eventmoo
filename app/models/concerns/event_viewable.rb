# Helper method for event views
module EventViewable
  extend ActiveSupport::Concern

  class_eval do
    def timings
      [self.start_time, self.end_time].join(' - ')
    end
  end
end
