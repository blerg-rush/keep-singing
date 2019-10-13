class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  NON_EMBEDDABLE_CHANNELS = %w[UCbqcG1rdt9LMwOJN4PyGTKg].freeze

  def trim(title)
    # existing
    title.to_s.gsub(/[\(\[]?karaoke version[\)\}]?/i, '')
         .gsub(/karaoke/i, '')
         .squish
  end
end
