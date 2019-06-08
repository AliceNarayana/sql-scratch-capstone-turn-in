Project CoolTShirts
(Identifing the best campaigns used to increase website visits
and purchased)


1. Description: This code will calculate how many compaigns the business used 
to advertise their brand:
Code: 
SELECT COUNT (DISTINCT utm_campaign)
FROM page_visits;


2. Description: This code will calculate how many sources this business used 
to advertise their brand:
Code:
SELECT COUNT (DISTINCT utm_source)
FROM page_visits;


3. Description: This code will expose how sources and compaign are related.
Code:
SELECT DISTINCT utm_campaign, utm_source
FROM page_visits;


4.Description: This code will expose what pages are on the business Website. 
Code: 
SELECT DISTINCT page_name
FROM page_visits;


5. Description: This code will expose which campaing are responsible for the first 
customers access.
CODE:
WITH first_touch AS (
        SELECT user_id,
        MIN(timestamp) as first_touch_at
        FROM page_visits
       GROUP BY user_id)
SELECT ft.user_id,
    ft.first_touch_at,
    pv.utm_source,
    pv.utm_campaign,
    COUNT (utm_campaign)
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
GROUP BY utm_campaign
ORDER BY 5 DESC;


6. Description: This code will expose which campaing are responsible for the last 
customers access.
CODE:
WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT lt.user_id,
    lt.last_touch_at,
    pv.utm_source,
    pv.utm_campaign,
    COUNT (utm_campaign)
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
GROUP BY utm_campaign
ORDER BY 5 DESC;


7. Description: This code will expose how many clients really processed payments.
Code: 
SELECT COUNT(DISTINCT user_id)
FROM page_visits
WHERE page_name = '4 - purchase';



8. Description: This code will expose how many last access on the purchase page, 
each campaign is responsible

WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    WHERE page_name = '4 - purchase'
    GROUP BY user_id)
SELECT lt.user_id,
    lt.last_touch_at,
    pv.utm_source,
    pv.utm_campaign,
    COUNT (utm_campaign)
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
GROUP BY utm_campaign
ORDER BY 5 DESC;


