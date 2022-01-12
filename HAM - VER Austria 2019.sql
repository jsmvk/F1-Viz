SELECT b.[driverId], 
	b.[lap], 
	[position], 
	b.[time], 
	[name], 
	[year], 
	[surname]
	FROM [dbo].[pit_stops] AS a
	RIGHT JOIN [dbo].[lap_times] AS b
	ON a.[driverId] = b.[driverId]
	RIGHT JOIN [dbo].[races] AS c
	ON b.[raceId] = c.[raceId]
	LEFT JOIN [dbo].[drivers] AS d
	ON b.[driverId] = d.[driverId]
	WHERE b.[driverId] = 1 AND 
	b.[lap] BETWEEN 20 AND 71 AND 
	c.[raceId] = 1018 AND 
	a.[raceId] = 1018
	ORDER BY b.[lap]; --Hamilton Autria 2019


SELECT b.[driverId],  
	b.[lap], 
	[position], 
	b.[time], 
	[name], 
	[year], 
	[surname]
	FROM [dbo].[pit_stops] AS a
	RIGHT JOIN [dbo].[lap_times] AS b
	ON a.[driverId] = b.[driverId]
	RIGHT JOIN [dbo].[races] AS c
	ON b.[raceId] = c.[raceId]
	LEFT JOIN [dbo].[drivers] AS d
	ON b.[driverId] = d.[driverId]
	WHERE b.[driverId] = 830 AND 
	b.[lap] BETWEEN 20 AND 71 AND 
	c.[raceId] = 1018 AND 
	a.[raceId] = 1018
	ORDER BY b.[lap]; --Verstappen Austria 2019

SELECT b.[driverId],  
	b.[lap], 
	[position], 
	b.[time], 
	[name], 
	[year], 
	[surname]
	FROM [dbo].[pit_stops] AS a
	RIGHT JOIN [dbo].[lap_times] AS b
	ON a.[driverId] = b.[driverId]
	RIGHT JOIN [dbo].[races] AS c
	ON b.[raceId] = c.[raceId]
	LEFT JOIN [dbo].[drivers] AS d
	ON b.[driverId] = d.[driverId]
	WHERE b.[driverId] = 844 AND 
	b.[lap] BETWEEN 20 AND 71 AND 
	c.[raceId] = 1018 AND 
	a.[raceId] = 1018
	ORDER BY b.[lap]; --Leclerc Austria 2019


SELECT [driverId], [stop], [lap], [duration]--, [time]
	FROM [dbo].[pit_stops]
	WHERE [raceId] = 1018 AND ([driverId] = 830 OR [driverId] = 1) --pit strategy

--exec sp_help races

SELECT [lap], COUNT([lap]) AS duplicates
	FROM [dbo].[pit_stops]
	WHERE [raceId] = 1018 AND 
	[driverId] = 1 
	GROUP BY [lap]
	HAVING COUNT([lap]) > 1 --verify for lap duplicates //hamilton

SELECT *
	FROM [dbo].[drivers]
	WHERE [surname] = 'Leclerc' --Charles Leclerc
	


