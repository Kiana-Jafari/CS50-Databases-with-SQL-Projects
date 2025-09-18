/*
    In 10.sql, write a SQL query to answer a question of your choice about the prints. The query should:
        • Make use of AS to rename a column
        • Involve at least one condition, using WHERE
        • Sort by at least one column, using ORDER BY

    Question: Which artist has a higher entropy (an entropy of above 7.80), and what colors did he use the most in his portraits?
*/

SELECT artist, entropy, average_color
FROM views
WHERE entropy > 7.80
ORDER BY average_color ASC;

/*
    Observation: The artist with the highest entropy is "Hiroshige" (rich detail/complexity), whose entropy grades are above 7.8, near 8.
    Based on the average color column, he mostly used cooler shades, which suggest a preference for naturalistic palettes, rather than the warm ones.
*/
