-- EC_IT143_6.3_fwf_s10_eo.sql

-- Update a row to trigger the AFTER UPDATE logic
UPDATE dbo.t_hello_world
SET my_message = 'Hello World4'
WHERE my_message = 'Hello World3';

-- Check the results
SELECT my_message, current_date_time, last_modified_date
FROM dbo.t_hello_world;