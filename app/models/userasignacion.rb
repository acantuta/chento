class Userasignacion < ActiveRecord::Base
  belongs_to :user
  belongs_to :area

  after_initialize :defaults

  def defaults
  	unless  persisted?
  		self.es_jefe = false
  	end
  end

end
