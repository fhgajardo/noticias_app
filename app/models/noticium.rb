class Noticium < ApplicationRecord
	has_many :comentarios
	validates_presence_of :fecha,
	 	:bajada, 
	 	:cuerpo,
	 	:titular
	validates_length_of :bajada, maximum: 200
end
