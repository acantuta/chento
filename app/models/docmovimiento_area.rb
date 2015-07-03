class DocmovimientoArea < Docmovimiento
	attr_accessor :area
	def as_json(options = { })    
	    super((options || { }).merge({
	        :methods => [:tags, :documento]
	    }))
	end

	def tags
	  items = []
	  if self.fuente?
	    items << ( self.enviado? ? 'enviado' : 'no enviado' )
	  end
	  
	  if self.destino?
	  	items << ( self.recibido? ? 'recibido' : 'no recibido' )
	  end
	  
	  return items
	end

	def fuente?
	  (self.area.id == self.area_fuente_id)
	end

	def destino?
	  (self.area.id == self.area_destino_id)
	end

	def enviado?
		self.recibido
	end

	def recibido?
		self.recibido
	end
end
