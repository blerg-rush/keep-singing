class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def trim(title)
    # existing
    title.to_s.gsub(/(K|k)araoke (V|v)ersion/, '')
         .gsub(/(K|k)araoke/, '')
         .squish
  end
end
