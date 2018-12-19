class User < ApplicationRecord
	validates :case_id, presence: true

	enum gender: {
		male: 'male',
		female: 'female',
		any: 'any'
	}
end
