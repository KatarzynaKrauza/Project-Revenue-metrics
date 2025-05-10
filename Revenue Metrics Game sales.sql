WITH payments_with_month AS (
    SELECT 
        user_id,
        DATE_TRUNC('month', payment_date) AS payment_month,
        payment_date,
        revenue_amount_usd
    FROM 
        project.games_payments
    WHERE 
        payment_date IS NOT NULL
        AND revenue_amount_usd IS NOT NULL
),
payments_ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY user_id, DATE_TRUNC('month', payment_date) ORDER BY payment_date) AS rn
    FROM payments_with_month
),
first_payment_per_user_month AS (
    SELECT
        user_id,
        payment_month,
        payment_date,
        revenue_amount_usd
    FROM payments_ranked
    WHERE rn = 1
),
monthly_mrr AS (
    SELECT
        user_id,
        payment_month,
        SUM(revenue_amount_usd) AS monthly_mrr
    FROM payments_with_month
    GROUP BY user_id, payment_month
),
first_payment_month AS (
    SELECT
        user_id,
        MIN(payment_month) AS first_payment_month
    FROM payments_with_month
    GROUP BY user_id
),
mrr_with_change AS (
    SELECT
        m.user_id,
        m.payment_month,
        m.monthly_mrr,
        LAG(m.monthly_mrr) OVER (PARTITION BY m.user_id ORDER BY m.payment_month) AS previous_mrr
    FROM monthly_mrr m
)
SELECT
    m.user_id,
    m.payment_month,
    fppm.payment_date,
    fppm.revenue_amount_usd,
    m.monthly_mrr,
    COALESCE(m.previous_mrr, 0) AS previous_mrr,
    CASE WHEN m.monthly_mrr > COALESCE(m.previous_mrr, 0)
    AND COALESCE(m.previous_mrr, 0) > 0 THEN m.monthly_mrr - m.previous_mrr ELSE 0 END AS expansion_mrr,
    CASE WHEN m.monthly_mrr < COALESCE(m.previous_mrr, 0)
    AND COALESCE(m.previous_mrr, 0) > 0 THEN m.previous_mrr - m.monthly_mrr ELSE 0 END AS contraction_mrr,
    CASE WHEN m.payment_month = fpm.first_payment_month THEN 1 ELSE 0 END AS is_new_user,
    CASE 
        WHEN NOT EXISTS (
            SELECT 1
            FROM monthly_mrr next_m
            WHERE next_m.user_id = m.user_id
              AND next_m.payment_month = m.payment_month + INTERVAL '1 month'
        )
        THEN 1 ELSE 0
    END AS is_churned
FROM
    mrr_with_change m
LEFT JOIN first_payment_month fpm ON m.user_id = fpm.user_id
LEFT JOIN first_payment_per_user_month fppm 
    ON m.user_id = fppm.user_id AND m.payment_month = fppm.payment_month
ORDER BY
    m.payment_month, m.user_id
