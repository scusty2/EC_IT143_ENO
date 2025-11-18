-- Q: What is the current date and time?

-- A:  Let's ask SQL server and find out..
DROP TABLE IF EXISTS dbo.t_hello_world;
GO
SELECT v.my_message,
       v.current_date_time
     INTO dbo.t_hello_world
  FROM dbo.v_hello_world_load AS v;

  EXEC dbo.usp_hello_world_load;