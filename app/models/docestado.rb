class Docestado < ActiveRecord::Base
	def self.tipos
		['procesando','finalizado','detenido']
	end

	def self.default
		self.tipos.first
	end
end
