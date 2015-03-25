class Docestado < ActiveRecord::Base
	def self.tipos
		['tramitando','finalizado','cancelado','detenido']
	end
end
