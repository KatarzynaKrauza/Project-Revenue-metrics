WITH first_payment AS (
    -- Znalezienie najwcześniejszej daty płatności dla każdego użytkownika
    SELECT 
        user_id,
        DATE_TRUNC('month', MIN(payment_date)) AS first_payment_month
    FROM 
        project.games_payments
    WHERE 
        payment_date IS NOT NULL 
        AND revenue_amount_usd IS NOT NULL
    GROUP BY 
        user_id
),
payments_with_month AS (
    -- Dodanie kolumny z pełną datą i miesiącem do płatności
    SELECT 
        user_id,
        DATE_TRUNC('month', payment_date) AS payment_month,
        payment_date,  -- Pełna data płatności
        revenue_amount_usd
    FROM 
        project.games_payments
    WHERE 
        payment_date IS NOT NULL
        AND revenue_amount_usd IS NOT NULL
),
monthly_summary AS (
    -- Agregacja MRR, new MRR i liczby nowych użytkowników na poziomie miesiąca
    SELECT
        p.payment_month,
        SUM(p.revenue_amount_usd) AS MRR,
        SUM(CASE 
                WHEN fp.first_payment_month = p.payment_month 
                THEN p.revenue_amount_usd 
                ELSE 0 
            END) AS new_mrr,
        COUNT(DISTINCT CASE 
                WHEN fp.first_payment_month = p.payment_month 
                THEN p.user_id 
                ELSE NULL 
            END) AS new_users
    FROM 
        payments_with_month p
    LEFT JOIN 
        first_payment fp 
        ON p.user_id = fp.user_id
    GROUP BY
        p.payment_month
),
next_month_payments AS (
    -- Ustalenie, czy użytkownik dokonał płatności w następnym miesiącu
    SELECT
        p.user_id,
        p.payment_month,
        p.payment_date,  -- Pełna data płatności
        p.revenue_amount_usd,
        LEAD(p.payment_month) OVER (PARTITION BY p.user_id ORDER BY p.payment_month) AS next_month_payment
    FROM
        payments_with_month p
),
churned_users AS (
    -- Znalezienie użytkowników, którzy zapłacili w bieżącym miesiącu, ale nie w następnym
    SELECT
        p.payment_month AS last_payment_month,
        COUNT(DISTINCT p.user_id) AS churned_users,
        SUM(p.revenue_amount_usd) AS churned_revenue
    FROM
        payments_with_month p
    LEFT JOIN
        next_month_payments nmp
        ON p.user_id = nmp.user_id
        AND p.payment_month = nmp.payment_month
    WHERE
        nmp.next_month_payment IS NULL  -- Użytkownicy, którzy nie dokonali płatności w następnym miesiącu
    GROUP BY
        p.payment_month
)
SELECT
    p.user_id,
    p.payment_date,  -- Wyświetlenie pełnej daty płatności
    p.payment_month,
    p.revenue_amount_usd,
    ms.MRR,  -- MRR: suma wszystkich przychodów dla danego miesiąca
    ms.new_mrr,  -- new MRR: suma przychodów dla nowych użytkowników
    ms.new_users,  -- new_users: liczba nowych użytkowników
    COALESCE(cu.churned_users, 0) AS churned_users,  -- churned_users: liczba churned users (0 jeśli nie ma churn)
    COALESCE(cu.churned_revenue, 0) AS churned_revenue  -- churned_revenue: suma przychodów od churned users (0 jeśli nie ma churn)
FROM
    payments_with_month p
LEFT JOIN
    monthly_summary ms
    ON p.payment_month = ms.payment_month
LEFT JOIN 
    churned_users cu
    ON p.payment_month = cu.last_payment_month  -- Połączenie na podstawie miesiąca
ORDER BY
    p.payment_month, 
    p.payment_date  -- Sortowanie również po pełnej dacie płatności

