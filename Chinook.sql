-- 1
SELECT
c.FirstName,
c.LastName,
c.CustomerId,
c.Country
FROM Customer c
WHERE c.Country is NOT "USA";

-- 2 
SELECT
c.FirstName,
c.LastName,
c.CustomerId,
c.Country
FROM Customer c
WHERE c.Country is "Brazil";

-- 3 
SELECT
c.FirstName,
c.LastName,
i.InvoiceId,
i.InvoiceDate,
i.BillingCountry
FROM Customer c
LEFT JOIN Invoice i on i.CustomerId = c.CustomerId
WHERE c.Country is "Brazil";

-- 4 
SELECT 
e.FirstName,
e.LastName,
e.Title
FROM Employee e
WHERE e.Title LIKE "%sales%" and e.Title LIKE "%agent%";

-- 5 
SELECT DISTINCT
i.BillingCountry
FROM Invoice i
ORDER BY i.BillingCountry;

-- 6
SELECT
i.InvoiceId,
e.FirstName as AgentFirstName,
e.LastName as AgentLastName
FROM Invoice i
JOIN Customer c on i.CustomerId = c.CustomerId
JOIN Employee e on c.SupportRepId = e.EmployeeId;

-- 7
SELECT
i.Total,
i.BillingCountry,
c.FirstName as CustomerFirstName,
c.LastName as CustomerLastName,
e.FirstName as AgentFirstName,
e.LastName as AgentLastName
FROM Invoice i
JOIN Customer c on i.CustomerId = c.CustomerId
JOIN Employee e on c.SupportRepId = e.EmployeeId;

-- 8
SELECT COUNT()
FROM Invoice i
WHERE i.InvoiceDate LIKE "%2009%" OR i.InvoiceDate LIKE "%2011%";

-- 9
SELECT SUM(Total)
FROM Invoice i
WHERE i.InvoiceDate LIKE "%2009%" OR i.InvoiceDate LIKE "%2011%";

-- 10
SELECT COUNT()
FROM InvoiceLine i 
WHERE i.InvoiceId IS "37";

-- 11
SELECT COUNT(), InvoiceId
FROM InvoiceLine i
GROUP BY InvoiceId;

-- 12
SELECT
i.InvoiceLineId,
t.Name as TrackName
FROM InvoiceLine i
JOIN Track t on t.TrackId = i.TrackId
ORDER BY i.InvoiceLineId;

-- 13
SELECT
i.InvoiceLineId,
t.Name as TrackName,
ar.Name as ArtistName
FROM InvoiceLine i
JOIN Track t on t.TrackId = i.TrackId
JOIN Album al on al.AlbumId = t.AlbumId
JOIN Artist ar on ar.ArtistId = al.ArtistId
ORDER BY i.InvoiceLineId;

-- 14
SELECT COUNT(), BillingCountry
FROM Invoice i
GROUP BY i.BillingCountry;

-- 15
SELECT COUNT(), p.Name
FROM PlaylistTrack pt
JOIN Playlist p on p.PlaylistId = pt.PlaylistId
GROUP BY pt.PlaylistId;

-- 16
SELECT 
t.Name,
a.Title,
m.Name,
g.Name
FROM Track t 
JOIN Album a on t.AlbumId = a.AlbumId
JOIN MediaType m on t.MediaTypeId = m.MediaTypeId
JOIN Genre g on t.GenreId = g.GenreId;

-- 17
SELECT COUNT(), InvoiceId
FROM InvoiceLine i
GROUP BY InvoiceId;

--18
SELECT SUM(Total),
e.FirstName,
e.LastName
FROM Employee e
JOIN Customer c on c.SupportRepId = e.EmployeeId
JOIN Invoice i on i.CustomerId = c.CustomerId
WHERE e.Title LIKE "%agent%"
GROUP BY e.EmployeeId;

--19
SELECT FirstName, LastName, Max(most) 
FROM (SELECT e.FirstName, e.LastName, SUM(Total) as most
FROM Employee e
JOIN Customer c on c.SupportRepId = e.EmployeeId
JOIN Invoice i on i.CustomerId = c.CustomerId
WHERE i.InvoiceDate LIKE "%2009%"
GROUP BY e.EmployeeId);

--20
SELECT FirstName, LastName, Max(most) 
FROM (SELECT e.FirstName, e.LastName, SUM(Total) as most
FROM Employee e
JOIN Customer c on c.SupportRepId = e.EmployeeId
JOIN Invoice i on i.CustomerId = c.CustomerId
GROUP BY e.EmployeeId);

--21
SELECT COUNT(),
e.FirstName,
e.LastName
FROM Customer c 
JOIN Employee e on c.SupportRepId = e.EmployeeId
GROUP BY c.SupportRepId;

--22
SELECT SUM(Total),
BillingCountry
FROM Invoice i
GROUP BY BillingCountry;

--23
SELECT BillingCountry, MAX(biggest)
	FROM (SELECT BillingCountry, SUM(Total) as biggest
	FROM Invoice
	GROUP BY BillingCountry);

--24
SELECT Name, MAX(most)
	FROM (SELECT Name, Count() as most
	FROM InvoiceLine il
	JOIN Track t on t.TrackId = il.TrackId
	JOIN Invoice i on i.InvoiceId = il.InvoiceId
	WHERE i.InvoiceDate LIKE "%2013%"
	GROUP BY il.TrackId);

--25
SELECT Name, COUNT()
FROM InvoiceLine il
JOIN Track t on t.TrackId = il.TrackId	
JOIN Invoice i on i.InvoiceId = il.InvoiceId
GROUP BY il.TrackId
ORDER BY Count() DESC
LIMIT 5;

--26
SELECT ar.Name , COUNT()
FROM InvoiceLine il
JOIN Track t on t.TrackId = il.TrackId
JOIN Album al on al.AlbumId = t.AlbumId
JOIN Artist ar on ar.ArtistId = al.ArtistId
GROUP BY ar.ArtistId
ORDER BY COUNT() DESC
LIMIT 3;

--27
SELECT m.Name , COUNT()
FROM InvoiceLine il
JOIN Track t on t.TrackId = il.TrackId
JOIN MediaType m on m.MediaTypeId = t.MediaTypeId
GROUP BY m.Name
ORDER BY COUNT() DESC;