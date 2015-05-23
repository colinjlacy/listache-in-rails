class List < ActiveRecord::Base
	serialize :list_items
	belongs_to :user
end
