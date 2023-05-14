CREATE PROCEDURE [dbo].[GetCustomers]
AS
   BEGIN
    SET NOCOUNT ON;

    SELECT userID, passsword, firstName, lastName, addressLine1, addressLine2, city, zipcode, state, emailAddress, phoneNumber
    FROM [ApplicationDB].[dbo].[Customers];
END
