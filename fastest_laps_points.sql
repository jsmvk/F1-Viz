SELECT TOP 1 WITH TIES 
	   c.[fastestLapTime], 
	   c.[points], 
	   a.[round], 
	   d.[surname]
	FROM dbo.[races] AS a
	LEFT JOIN dbo.[driver_standings] AS b
	ON a.[raceId] = b.[raceId]
	JOIN dbo.[results] AS c
	ON b.[raceId] = c.[raceId]
	LEFT JOIN dbo.[drivers] AS d
	ON d.[number] = c.[number]
	WHERE [year] = 2014 
	--AND d.[surname] = 'Hamilton'
	--OR d.[surname] = 'Rosberg'
	AND c.[fastestLapTime] != '\N'
	ORDER BY ROW_NUMBER() OVER(PARTITION BY a.[round] ORDER BY c.[fastestLapTime])



