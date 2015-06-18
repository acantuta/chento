class Documento < ActiveRecord::Base
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

  scope :descendente, ->{ order(created_at: :desc)}

  after_initialize :after_init

  after_save {
    if self.estado_changed?
      Doclog.create(documento_id: self.id, contenido: "Ha cambiado de estado: #{self.estado_was} a #{self.estado}")
    end
  }

  def after_init
  	unless self.persisted?
  		self.folios||='1'
  		self.ambiente||='interno'
  	end
  end


end
