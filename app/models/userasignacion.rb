class Userasignacion < ActiveRecord::Base
  belongs_to :user
  belongs_to :area
  scope :jefes, -> { where(es_jefe: true)}
  after_initialize :defaults

  def defaults
  	if not  self.persisted?
  		self.es_jefe ||= false
  	end
  end

end
