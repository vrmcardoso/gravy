class Contact < ActiveRecord::Base
  include AlgoliaSearch

  algoliasearch do
    # Use all default configuration
  end
end
