SELECT

  COUNT(*) AS total_orders,

  SUM(RobotDetectsDefects) AS total_defects,

  ROUND(SAFE_DIVIDE(SUM(RobotDetectsDefects), COUNT(*)) * 100, 2) AS defect_rate,

  COUNT(DISTINCT PickStationID) AS pick_stations,

  COUNT(DISTINCT PackStationID) AS pack_stations

  FROM `warehousefulfillmentanalytics.warehouse_fulfillment_analytics.fact_warehouse_orders`;
