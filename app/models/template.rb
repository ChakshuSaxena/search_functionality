class Template < ApplicationRecord
    scope :filter_by_provider, -> (provider) { where provider: provider }
    include Filterable
end
