# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

buildings_list = [
  ['A.W. Smith Building', 'aw-smith', 'academic', 41.50296, -81.60686, nil],
  ['Adelbert Gym', 'adelbert-gym', 'athletic', 41.5031, -81.60592, nil],
  ['Adelbert Hall', 'adelbert-hall', 'administrative', 41.504813888889004, -81.608216666667, nil],
  ['Clapp Hall', 'clapp', 'academic', 41.504011, -81.60690799999999, '<p>Also known as Agnar Pytte Science Center. Contains Hovorka Atrium.</p>'],
  ['DeGrace Hall', 'degrace', 'academic', 41.504183, -81.607106, nil],
  ['Millis Schmitt Hall', 'millis-schmitt', 'academic', 41.504166, -81.607494, '<p>Includes Schmitt Auditorium.</p>'],
  ['Allen Memorial Library', 'allen-library', 'administrative', 41.50597, -81.60844, '<p>Also contains the Dittrick Museum of Medical History.</p>'],
  ['Amasa Stone Chapel', 'amasa-stone', 'other', 41.50492, -81.60906, nil],
  ['Bellflower Hall', 'bellflower', 'academic', 41.51193, -81.605209, nil],
  ['Bingham Building', 'bingham', 'academic', 41.502500000000005, -81.60694, nil],
  ['Biomedical Research Building', 'biomedical-research-building', 'academic', 41.505006, -81.604407, nil],
  ['Carlton Commons', 'carlton', 'other', 41.5002572, -81.6017622, nil],
  ['Clark Hall', 'clark-hall', 'academic', 41.50897, -81.60749, nil],
  ['Crawford Hall', 'crawford', 'administrative', 41.504598, -81.6098, nil],
  ['Dively Building', 'dively', 'academic', 41.510200000000005, -81.60656, nil],
  ['Eldred Hall', 'eldred', 'academic', 41.50402, -81.60781999999999, nil],
  ['Fribley Commons', 'fribley', 'other', 41.50111, -81.60267999999999, nil],
  ['Glennan Building', 'glennan', 'academic', 41.50157, -81.60719, nil],
  ['Guilford House', 'guilford-house', 'academic', 41.508545, -81.60815099999999, nil],
  ['Harkness Chapel', 'harkness-chapel', 'academic', 41.509339999999995, -81.60750999999999, nil],
  ['Haydn Hall', 'haydn-hall', 'academic', 41.50863, -81.60770000000001, nil],
  ['Kelvin Smith Library', 'ksl', 'academic', 41.507269444440006, -81.60950277777, '<p>A <a href="http://library.case.edu/ksl/services/facilities/maps/">floor map can be found here</a> (requires Flash).</p>'],
  ['Kent Hale Smith Building', 'kent-hale-smith', 'academic', 41.503344, -81.60656, nil],
  ['Leutner Commons', 'leutner', 'other', 41.51357, -81.60602, nil],
  ['Mandel Community Center', 'mandel-community-center', 'academic', 41.511, -81.60560000000001, nil],
  ['Mandel School', 'msass', 'academic', 41.510433, -81.607218, nil],
  ['Mather Dance Center', 'mather-dance-center', 'athletic', 41.50823, -81.60815, nil],
  ['Mather House', 'mather-house', 'academic', 41.507861999999996, -81.60786, nil],
  ['Mather Memorial Building', 'mather-memorial-building', 'academic', 41.509557, -81.607078, nil],
  ['Morley Building', 'morley', 'academic', 41.504000000000005, -81.607, '<p class="warning">Morley may be closed pending hazmat cleanup. Go at your own risk.</p>'],
  ['Nord Hall', 'nord', 'academic', 41.502559999999995, -81.6079, nil],
  ['Olin Building', 'olin', 'academic', 41.50224, -81.60777999999999, nil],
  ['Peter B. Lewis Building', 'pbl', 'academic', 41.50983, -81.6079, nil],
  ['Rockefeller Building', 'rockefeller', 'academic', 41.50364, -81.60784, nil],
  ['Sears Building', 'sears', 'academic', 41.502733333333005, -81.608183333333, nil],
  ['Strosacker Auditorium', 'strosacker', 'academic', 41.5032985, -81.6074699, nil],
  ['think[box]', 'thinkbox', 'other', 41.500538, -81.605764, nil],
  ['Thwing Center', 'thwing', 'administrative', 41.507452, -81.60813499999999, '<p>A <a href="https://students.case.edu/thwing/facilities/floorplan/">floor map can be found here</a>.</p>'],
  ['Tinkham Veale Center', 'tinkham-veale', 'administrative', 41.508027999999996, -81.608667, nil],
  ['Tomlinson Hall', 'tomlinson', 'administrative', 41.50404166666701, -81.6096, nil],
  ['Veale Center', 'veale', 'athletic', 41.501394, -81.60549, nil],
  ['Wade Commons', 'wade', 'other', 41.51304, -81.60525, nil],
  ['White Building', 'white', 'academic', 41.50197, -81.60746, nil],
  ['Wickenden Building', 'wickenden', 'academic', 41.503086111111, -81.608452777778, nil],
  ['Wolstein Research Building', 'wolstein', 'administrative', 41.506403999999996, -81.603168, nil],
  ['Wyant Athletic Center', 'wyant', 'athletic', 41.514345, -81.60341199999999, nil],
  ['Yost Hall', 'yost', 'academic', 41.503569444444004, -81.60897777777801, nil]
]

buildings_list.each do |name, slug, building_type, latitude, longitude, blurb|
  unless Building.exists?(slug: slug)
    Building.create(
      name: name,
      slug: slug,
      building_type: Building.building_types[building_type],
      latitude: latitude,
      longitude: longitude,
      blurb: blurb
    )
  end
end

buildings_with_basements = [
  ["adelbert-gym", 1, "LL", "ll"],
  ["adelbert-hall", 4, "B1", "b1"],
  ["allen-library", 3, "B1", "b1"],
  ["aw-smith", 4, "B1", "basement"],
  ["biomedical-research-building", 10, "B1", "b1"],
  ["bingham", 3, "B1", "b1"],
  ["crawford", 7, "LL", "ll"],
  ["eldred", 3, "B1", "basement"],
  ["guilford-house", 3, "B1", "b1"],
  ["haydn-hall", 3, "B1", "b1"],
  ["ksl", 3, "LL", "ll"],
  ["leutner", 1, "L3", "l3"],
  ["mather-dance-center", 2, "B1", "b1"],
  ["mather-memorial-building", 2, "B1", "b1"],
  ["morley", 3, "B1", "b1"],
  ["pbl", 5, "LL", "ll"],
  ["thwing", 3, "LL", "ll"],
  ["tinkham-veale", 2, "B1", "b1"],
  ["wyant", 2, "B1", "b1"]
]

def create_aboveground_floors(building_id, top_floor)
  (1..top_floor).each do |level|
    unless Floor.exists?(building_id: building_id, level: level)
      Floor.create(
        building_id: building_id,
        slug: level.to_s,
        level: level
      )
    end
  end
end

buildings_with_basements.each do |building_slug, top_level, basement_name, basement_slug|
  building = Building.find_by!(slug: building_slug)

  unless Floor.exists?(building_id: building.id, level: -1)
    Floor.create(
      building_id: building.id,
      name: basement_name,
      slug: basement_slug,
      level: -1
    )
  end

  create_aboveground_floors(building.id, top_level)
end


buildings_without_basements = [
  ["amasa-stone", 2],
  ["bellflower", 1],
  ["carlton", 2],
  ["clapp", 4],
  ["clark-hall", 4],
  ["degrace", 3],
  ["dively", 2],
  ["fribley", 2],
  ["glennan", 8],
  ["harkness-chapel", 1],
  ["kent-hale-smith", 5],
  ["mandel-community-center", 2],
  ["mather-house", 4],
  ["millis-schmitt", 3],
  ["msass", 3],
  ["nord", 4],
  ["olin", 8],
  ["rockefeller", 4],
  ["sears", 6],
  ["strosacker", 2],
  ["thinkbox", 7, 1],
  ["tomlinson", 3],
  ["veale", 4],
  ["wade", 1],
  ["white", 5],
  ["wickenden", 5],
  ["wolstein", 2],
  ["yost", 4]
]

buildings_without_basements.each do |building_slug, top_level|
  building = Building.find_by!(slug: building_slug)
  create_aboveground_floors(building.id, top_level)
end