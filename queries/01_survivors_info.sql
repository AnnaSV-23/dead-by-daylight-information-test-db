-- Информация о выживших: имя, глава, их перки
SELECT
    s.surv_name AS survivor_name,
    c.chapter AS chapter_number,
    c.chapter_title,
    string_agg(sp.perk_name, ', ' ORDER BY sp.perk_name) AS perks
FROM survivors s
JOIN chapters c ON c.chapter = s.surv_chapter
LEFT JOIN survivor_perks sp ON sp.surv_name = s.surv_name
GROUP BY s.surv_name, c.chapter, c.chapter_title
ORDER BY c.chapter, s.surv_name;v