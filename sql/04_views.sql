CREATE OR REPLACE VIEW

`warehousefulfillmentanalytics.warehouse_fulfillment_analytics.v_tableau_master`
AS

SELECT

  OrderMonth,

  CASE
    WHEN ShiftName = '11' THEN 'Night'
    WHEN LOWER(ShiftName) = 'morning' THEN 'Morning'
    WHEN LOWER(ShiftName) = 'mid' THEN 'Mid'
    WHEN LOWER(ShiftName) = 'afternoon' THEN 'Afternoon'
    WHEN LOWER(ShiftName) = 'night' THEN 'Night'
    ELSE 'Unknown'
    END AS ShiftName,

    PickStationID,
    PackStationID,

  COUNT(*) AS total_orders,
  SUM(RobotDetectsDefects) AS total_defects,

  SAFE_DIVIDE(SUM(RobotDetectsDefects), COUNT(*)) * 100 AS defect_rate
FROM `warehousefulfillmentanalytics.warehouse_fulfillment_analytics.fact_warehouse_orders`
GROUP BY OrderMonth,
         ShiftName,
         PickStationID,
         PackStationID;
