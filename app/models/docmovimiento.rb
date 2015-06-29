class Docmovimiento < ActiveRecord::Base
	belongs_to :area_fuente, class_name: 'Area'
	belongs_to :area_destino, class_name: 'Area'
	belongs_to :movaccion
	belongs_to :documento

	validates :area_destino, presence: true
	validates :area_fuente, presence: true

	scope :descendente, ->{ order(created_at: :desc)}

	after_initialize :after_init
	after_save {	  
	  if self.recibido==false
	  	referencias = self.documento.docreferencias.all
	  	if referencias.count > 0
	  	  referencias.each do |ref|	  	  	
		    Doclog.create!(documento_id: ref.documento_hijo_id, contenido: "Se ha creado documento: \"#{self.documento.nro}\", con asunto: \"#{self.documento.asunto}\" con destino a \"#{self.area_destino.nombre}\"")
		  end
		end
	  end
	}
	validates :documento, presence: true

	def after_init
		unless self.persisted?
			self.recibido = false
		end
	end


end
