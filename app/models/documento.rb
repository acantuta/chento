class Documento < ActiveRecord::Base
  belongs_to :doctipo
  belongs_to :docestado
  belongs_to :user
  belongs_to :area_generadora, class_name: "Area"
  has_many :docmovimientos
  has_many :docreferencias, foreign_key: :documento_padre_id
  validates :user, presence: true
  validates :area_generadora, presence: true
  validates :asunto, presence: true
  validates :remitente, presence: true

  scope :descendente, ->{ order(created_at: :desc)}

  after_initialize :after_init

  def after_init
  	unless self.persisted?
  		self.folios||='1'
  		self.ambiente||='interno'
  	end
  end


end
