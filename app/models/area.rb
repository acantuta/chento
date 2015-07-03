class Area < ActiveRecord::Base
	has_many :userasignaciones
	has_many :users, through: :userasignaciones
	has_many :movimientos, foreign_key: :area_fuente_id
	
	def movimientos_fuente(params = {})
	  items = DocmovimientoArea.where(area_fuente_id: self.id).where(recibido: true).descendente
	  items = self.buscar_texto(items, params[:texto_buscar]) unless params[:texto_buscar].blank?
	  items = self.wrap_movimientos(items)
	  return items
	end

	def movimientos_destino(params = {})
	  items = DocmovimientoArea.where(area_destino_id: self.id)
	  items = self.buscar_texto(items, params[:texto_buscar]) unless params[:texto_buscar].blank?
	  items = self.wrap_movimientos(items)
	  return items
	end

	def movimientos_fuente_destino(params = {})
	  items = DocmovimientoArea.where("area_fuente_id = ? or area_destino_id = ?", self.id, self.id)	  
	  items = self.buscar_texto(items, params[:texto_buscar]) unless params[:texto_buscar].blank?
	  items = self.wrap_movimientos(items)
	  return items
	end

	def recibir_documento(options={})
		if options
			
		end
	end

	def jefes
		self.userasignaciones.jefes.map(&:user)
	end

	def movimientos_enviados(params = {})
	  items = DocmovimientoArea.where(area_fuente_id: self.id).where(recibido: true).descendente
	  items = self.buscar_texto(items, params[:texto_buscar]) unless params[:texto_buscar].blank?
	  items = self.wrap_movimientos(items)
	  return items
	end

	def movimientos_esperando(params = {})
	  items = DocmovimientoArea.where(area_fuente_id: self.id).where(recibido: false).descendente
	  items = self.buscar_texto(items, params[:texto_buscar]) unless params[:texto_buscar].blank?
	  items = self.wrap_movimientos(items)
	  return items
	end

	def movimientos_recibir(params = {})
	  items = DocmovimientoArea.where(area_destino_id: self.id).where(recibido: false).descendente
	  items = self.buscar_texto(items, params[:texto_buscar]) unless params[:texto_buscar].blank?
	  items = self.wrap_movimientos(items)
	  return items
	end

	def movimientos_recibidos(params = {})	  
	  items = DocmovimientoArea.where(area_destino_id: self.id).where(recibido: true).descendente
	  items = self.buscar_texto(items, params[:texto_buscar]) unless params[:texto_buscar].blank?
	  items = self.wrap_movimientos(items)
	  return items
	end

	def buscar_texto(relation, texto_buscar)
		texto_buscar = "%#{texto_buscar}%"
		if relation.kind_of? ActiveRecord::Relation
			return relation.joins(:documento).where("documentos.asunto ILIKE ? or documentos.remitente ILIKE ?", texto_buscar, texto_buscar)
		end
		relation
	end

	
	  def wrap_movimientos(items)
	    items = items.includes(:documento).to_a
		items.each do |item|
	      item.area = self
	    end
	    return items
	  end
end
