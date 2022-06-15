/*CREATE VIEW [fast lap] AS*/
SELECT TOP 1 WITH TIES 
	a.[time], [name], [year], [surname]
	FROM dbo.[lap_times] AS a
	LEFT JOIN dbo.[races] AS b
	ON a.[raceId] = b.[raceId]
	LEFT JOIN dbo.[drivers] AS c
	ON c.[driverId] = a.[driverId]
	WHERE ([year] = 2019)
	ORDER BY ROW_NUMBER() OVER(PARTITION BY [name] ORDER BY a.[time])

--GO

SELECT TOP 5 [time], [name], [year], [surname]
	FROM [fast lap]
	ORDER BY [time] --Top times for every track in 2019
	
