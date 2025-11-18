-- Q: What is the current date and time?

-- A:  Let's ask SQL server and find out..
SELECT 'Hello World' As my_message,
      GETDATE() AS current_date_time;
      EXEC dbo.usp_hello_world_load;