        SELECT
                ID_USER,
                ACTIVATION_MONTH,
                SUM(VALUE)
         FROM <TABLE>
        GROUP BY 1, 2
        HAVING SUM(VALUE) > 500
        QUALIFY ROW_NUMBER() OVER (ORDER BY ACTIVATION_MONTH ASC) = 1;
