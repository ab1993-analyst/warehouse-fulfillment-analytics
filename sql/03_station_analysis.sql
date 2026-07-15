-- PICK STATION PERFORMANCE

SELECT

  PickStationID,

  COUNT(*) AS total_orders,

  SUM(RobotDetectsDefects) AS total_defects,

  ROUND(SAFE_DIVIDE(SUM(RobotDetectsDefects), COUNT(*)) * 100, 2) AS defect_rate

  FROM `warehousefulfillmentanalytics.warehouse_fulfillment_analytics.fact_warehouse_orders`

GROUP BY PickStationID

ORDER BY defect_rate DESC;

-- PACK STATION PERFORMANCE
SELECT

  PackStationID,

  COUNT(*) AS total_orders,

  SUM(RobotDetectsDefects) AS total_defects,

  ROUND(SAFE_DIVIDE(SUM(RobotDetectsDefects), COUNT(*)) * 100, 2) AS defect_rate

  FROM `warehousefulfillmentanalytics.warehouse_fulfillment_analytics.fact_warehouse_orders`

GROUP BY PackStationID

ORDER BY defect_rate DESC;

-- PICK STATION QUALITY VIEW

CREATE OR REPLACE VIEW

`warehousefulfillmentanalytics.warehouse_fulfillment_analytics.v_pick_station_quality`

AS

SELECT

  PickStationID,

  COUNT(*) AS total_orders,

  SUM(RobotDetectsDefects) AS defects,

  ROUND(

    100.0 * SUM(RobotDetectsDefects) / COUNT(*),

    2

  ) AS defect_rate_percent

FROM `warehousefulfillmentanalytics.warehouse_fulfillment_analytics.fact_warehouse_orders`

GROUP BY PickStationID;

-- PACK STATION QUALITY VIEW

CREATE OR REPLACE VIEW

`warehousefulfillmentanalytics.warehouse_fulfillment_analytics.v_pack_station_quality`

AS

SELECT

  PackStationID,

  COUNT(*) AS total_orders,

  SUM(RobotDetectsDefects) AS defects,

  ROUND(

    100.0 * SUM(RobotDetectsDefects) / COUNT(*),

    2

  ) AS defect_rate_percent

FROM `warehousefulfillmentanalytics.warehouse_fulfillment_analytics.fact_warehouse_orders`

GROUP BY PackStationID;

-- WORST PICK STATIONS

SELECT

  PickStationID,

  COUNT(*) AS defects

FROM `warehousefulfillmentanalytics.warehouse_fulfillment_analytics.fact_warehouse_orders`

WHERE RobotDetectsDefects = 1

GROUP BY PickStationID

ORDER BY defects DESC

LIMIT 10;

-- WORST PACK STATIONS

SELECT

  PackStationID,

  COUNT(*) AS total_defects

FROM `warehousefulfillmentanalytics.warehouse_fulfillment_analytics.fact_warehouse_orders`

WHERE RobotDetectsDefects = 1

GROUP BY PackStationID

ORDER BY total_defects DESC

LIMIT 10;

-- WORST PICK STATIONS BY DEFECT RATE
SELECT

  PickStationID,

  COUNT(*) AS total_orders,

  SUM(RobotDetectsDefects) AS defects,

  ROUND(100.0 * SUM(RobotDetectsDefects) / COUNT(*), 2) AS defect_rate

FROM `warehousefulfillmentanalytics.warehouse_fulfillment_analytics.fact_warehouse_orders`

GROUP BY PickStationID

ORDER BY defect_rate DESC

LIMIT 10;

-- WORST PACK STATIONS BY DEFECT RATE

SELECT

  PackStationID,

  COUNT(*) AS total_orders,

  SUM(RobotDetectsDefects) AS defects,

  ROUND(100.0 * SUM(RobotDetectsDefects) / COUNT(*), 2) AS defect_rate_percent

FROM `warehousefulfillmentanalytics.warehouse_fulfillment_analytics.fact_warehouse_orders`

GROUP BY PackStationID

ORDER BY defect_rate_percent DESC

LIMIT 10;





