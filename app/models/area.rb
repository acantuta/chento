class Area < ActiveRecord::Base
	has_many :userasignaciones
	has_many :users, through: :userasignaciones
end
