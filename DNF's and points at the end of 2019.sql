SELECT [surname], [status], [position], [name], b.[year]
	--LENGTH(position) AS 'number of accidents'
	FROM [dbo].[races] AS a
	LEFT JOIN [seasons] AS b
	ON b.[year] = a.[year]
	LEFT JOIN [dbo].[results] AS c
	ON c.[raceId] = a.[raceId]
	LEFT JOIN [drivers] AS d
	ON d.[driverId] = c.[driverId]
	LEFT JOIN [status] AS e
	ON e.[statusId] = c.[statusId]
	WHERE b.[year] = 2019 
	AND (c.[raceId] <= 1030 AND c.[raceId] >= 1010)
	AND ([status] != 'Finished' 
	AND [status] NOT LIKE '+%'
	AND [position] = '\N')
	ORDER BY [surname]; --drivers that didn't finish races 2019

SELECT [points], [surname], [year]
	FROM [dbo].[driver_standings] AS a
	LEFT JOIN [dbo].[races] AS b
	ON a.[raceId] = b.[raceId]
	LEFT JOIN [dbo].[drivers] AS c
	ON a.[driverId] = c.[driverId]
	WHERE [year] = 2019 AND a.[raceId] = 1030
	ORDER BY [points] DESC; --points 2019
