class Docmovimiento < ActiveRecord::Base
	belongs_to :area_fuente, class_name: 'Area'
	belongs_to :area_destino, class_name: 'Area'
	belongs_to :movaccion
	belongs_to :documento

	scope :descendente, ->{ order(created_at: :desc)}

	after_initialize :after_init

	validates :documento, presence: true

	def after_init
		unless self.persisted?
			self.recibido = false
		end
	end
end
