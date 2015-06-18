class Area < ActiveRecord::Base
	has_many :userasignaciones
	has_many :users, through: :userasignaciones
	has_many :movimientos, foreign_key: :area_fuente_id
	
	def movimientos_fuente
		Docmovimiento.where(area_fuente_id: self.id)
	end

	def movimientos_destino
		Docmovimiento.where(area_destino_id: self.id)
	end

	def movimientos_fuente_destino
	  Docmovimiento.where("area_fuente_id = ? or area_destino_id = ?", self.id, self.id)
	end

	def recibir_documento(options={})
		if options
			
		end
	end

	def jefes
		self.userasignaciones.jefes.map(&:user)
	end
end
