class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def trim(title)
    title.to_s.gsub(/[\(\[]?karaoke version[\)\}]?/i, '')
         .gsub(/[\(\[]?karaoke[\)\}]?/i, '')
         .gsub('&#39;', "'")
         .squish
  end
end
