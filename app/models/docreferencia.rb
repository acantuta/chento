class Docreferencia < ActiveRecord::Base
	belongs_to :documento_padre, class_name: 'Documento'
	belongs_to :documento_hijo, class_name: 'Documento'
end
