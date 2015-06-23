class Area < ActiveRecord::Base
	has_many :userasignaciones
	has_many :users, through: :userasignaciones
	has_many :movimientos, foreign_key: :area_fuente_id
	
	def movimientos_fuente(params = {})
	  items = Docmovimiento.where(area_fuente_id: self.id)
	  items = self.buscar_texto(items, params[:texto_buscar]) unless params[:texto_buscar].blank?
	  return items
	end

	def movimientos_destino(params = {})
	  items = Docmovimiento.where(area_destino_id: self.id)
	  items = self.buscar_texto(items, params[:texto_buscar]) unless params[:texto_buscar].blank?
	  return items
	end

	def movimientos_fuente_destino(params = {})
	  items = Docmovimiento.where("area_fuente_id = ? or area_destino_id = ?", self.id, self.id)	  
	  items = self.buscar_texto(items, params[:texto_buscar]) unless params[:texto_buscar].blank?
	  return items
	end

	def recibir_documento(options={})
		if options
			
		end
	end

	def jefes
		self.userasignaciones.jefes.map(&:user)
	end


	def buscar_texto(relation, texto_buscar)
		texto_buscar = "%#{texto_buscar}%"
		if relation.kind_of? ActiveRecord::Relation
			return relation.joins(:documento).where("documentos.asunto ILIKE ? or documentos.remitente ILIKE ?", texto_buscar, texto_buscar)
		end
		relation
	end
end
