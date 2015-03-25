class Documento < ActiveRecord::Base
  belongs_to :doctipo
  belongs_to :docestado
  belongs_to :user
  belongs_to :area_generadora, class_name: "Area"

  validates :user, presence: true
  validates :area_generadora, presence: true
end
