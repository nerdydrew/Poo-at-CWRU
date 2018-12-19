class Building < ApplicationRecord
	enum type: {
		academic: 'academic',
		administrative: 'administrative',
		athletic: 'athletic',
		other: 'other',
		residential: 'residential',
		restaurant: 'restaurant'
	}
end
