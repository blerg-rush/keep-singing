class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  NON_EMBEDDABLE_CHANNELS = %w[UCbqcG1rdt9LMwOJN4PyGTKg
                               UCYi9TC1HC_U2kaRAK6I4FSQ].freeze
end
