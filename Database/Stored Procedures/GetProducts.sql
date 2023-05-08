CREATE PROCEDURE [dbo].[GetProducts]
AS
   BEGIN
    SET NOCOUNT ON;

    SELECT ProductId, ProductName, manufacturer, category, expirationDate, price
    FROM [ApplicationDB].[dbo].[Products];
END
