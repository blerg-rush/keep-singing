class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def trim(title)
    # existing
    title.to_s.gsub(/[\(\[]?karaoke version[\)\}]?/i, '')
         .gsub(/karaoke/i, '')
         .squish
  end
end
