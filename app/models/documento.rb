class Documento < ActiveRecord::Base
  attr_accessor :movimiento, :documento_hijo

  belongs_to :doctipo
  belongs_to :docestado
  belongs_to :user
  belongs_to :area_generadora, class_name: "Area"
  has_many :docmovimientos
  has_many :docreferencias, foreign_key: :documento_padre_id
  has_many :doclogs
  validates :user, presence: true
  validates :area_generadora, presence: true
  validates :asunto, presence: true
  validates :remitente, presence: true
  validates :doctipo, presence: true
  
  validate {
    @errors.add('Destinatario', 'es inválido') if @movimiento and not @movimiento.valid?
  }

  scope :descendente, ->{ order(created_at: :desc)}

  after_initialize :after_init

  after_save {
    
    if self.id_changed?
      Doclog.create(documento_id: self.id, contenido: "Se ha registrado documento.")

      #Graba referencias el documento
      if @documento_hijo
        doc_hijo_id = @documento_hijo.id

        #Obteniendo las referencias del documento hijo.            
        refs_hijo = Docreferencia.where(documento_padre_id: doc_hijo_id).all

        #Inserta las referencias del documento hijo.
        refs_hijo.each do |ref|              
          Docreferencia.create!(documento_padre_id: self.id, documento_hijo_id: ref.documento_hijo_id)
        end

        Docreferencia.create!(documento_padre_id: self.id, documento_hijo_id: doc_hijo_id)
      end
    end

    if self.estado_changed?
      Doclog.create(documento_id: self.id, contenido: "Ha cambiado de estado: #{self.estado_was} a #{self.estado}")
    end
  }

  def after_init
  	unless self.persisted?
  		self.folios||='1'
  		self.ambiente||='interno'
      self.estado = Docestado.default
  	end
  end


end
