class Documento < ActiveRecord::Base
  belongs_to :doctipo
  belongs_to :docestado
  belongs_to :user
  validates :user, presence: true
end
