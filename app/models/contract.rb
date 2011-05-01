class Contract < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 50
end
