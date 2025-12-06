-- Q: How can I keep track of when a record was last modified?
-- A: CREATE a Trigger for everytime that there is an update.
-- research source: https://stackoverflow.com/questions/9522982/t-sql-trigger-update
-- https://stackoverflow.com/questions/4574010/how-to-create-trigger-to-keep-track-of-last-changed-data
CREATE TRIGGER tr_hello_world_last_mod
ON dbo.t_hello_world
AFTER UPDATE
AS
BEGIN
    UPDATE h
    SET last_modified_date = GETDATE()
    FROM dbo.t_hello_world AS h
    INNER JOIN inserted AS i ON h.my_message = i.my_message;
END;
GO

