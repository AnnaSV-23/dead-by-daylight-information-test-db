-- Информация об убийцах: имя, имя до игры, глава, сила, перки, скорость, террор-радиус и карта
SELECT
    k.klr_name AS killer_name,
    k.klr_pregame_name AS past_name,
    c.chapter AS chapter_number,
    c.chapter_title,
    k.klr_power AS killer_power,
    k.klr_speed AS killer_speed,
    k.klr_terror_radius AS killer_terror_radius,
    string_agg(DISTINCT kp.perk_name, ', ' ORDER BY kp.perk_name) AS perks,
    string_agg(DISTINCT m.map_name,  ', ' ORDER BY m.map_name) AS associated_maps
FROM killers k
JOIN chapters c ON c.chapter = k.klr_chapter
LEFT JOIN killer_perks kp ON kp.klr_name = k.klr_name
LEFT JOIN maps m
      ON m.map_chapter = k.klr_chapter
      AND (
            k.klr_name NOT IN ('The Trapper', 'The Wraith', 'The Hillbilly')
            OR (k.klr_name = 'The Trapper' AND m.map_name = 'MacMillan Estate')
            OR (k.klr_name = 'The Wraith' AND m.map_name = 'Autoheaven Wreckers')
            OR (k.klr_name = 'The Hillbilly' AND m.map_name = 'Coldwind Farm')
          ) -- фууу хромая с костылями хожу
GROUP BY
    k.klr_name,
    k.klr_pregame_name,
    c.chapter,
    c.chapter_title,
    k.klr_power,
    k.klr_speed,
    k.klr_terror_radius
ORDER BY c.chapter;