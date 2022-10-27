
DECLARE @pID uniqueidentifier;
SET @pID = NEWID();
INSERT INTO Product (ID, Name, Description) VALUES (@pID,'Name 01',NULL)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 01', NULL, 5,7,9)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 02', NULL, 15,17,19)
SET @pID = NEWID();
INSERT INTO Product (ID,Name, Description) VALUES (@pID,'Name 02',NULL)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 01', NULL, 25,27,29)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 02', NULL, 35,37,39)

SET @pID = NEWID();
INSERT INTO Product (ID,Name, Description) VALUES (@pID,'Name 03',NULL)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 01', NULL, 45,47,49)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 02', NULL, 55,57,59)

SET @pID = NEWID();
INSERT INTO Product (ID,Name, Description) VALUES (@pID,'Name 04',NULL)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 01', NULL, 65,67,69)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 02', NULL, 75,77,79)
SET @pID = NEWID();
INSERT INTO Product (ID,Name, Description) VALUES (@pID,'Name 05',NULL)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 01', NULL, 85,87,89)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 02', NULL, 95,97,99)
SET @pID = NEWID();
INSERT INTO Product (ID,Name, Description) VALUES (@pID,'Name 06',NULL)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 01', NULL, 3,5,7)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 02', NULL, 13,15,17)
SET @pID = NEWID();
INSERT INTO Product (ID,Name, Description) VALUES (@pID,'Name 07',NULL)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 01', NULL, 23,25,27)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 02', NULL, 33,35,37)

SET @pID = NEWID();
INSERT INTO Product (ID,Name, Description) VALUES (@pID,'Name 08',NULL)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 01', NULL, 43,45,47)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 02', NULL, 53,55,57)
SET @pID = NEWID();
INSERT INTO Product (ID,Name, Description) VALUES (@pID,'Name 09',NULL)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 01', NULL, 63,65,67)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 02', NULL, 73,75,77)
SET @pID = NEWID();
INSERT INTO Product (ID,Name, Description) VALUES (@pID,'Name 10',NULL)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 01', NULL, 83,85,87)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 02', NULL, 93,95,97)
SET @pID = NEWID();
INSERT INTO Product (ID,Name, Description) VALUES (@pID,'Name 11',NULL)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 01', NULL, 5,7,9)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 02', NULL, 15,17,19)
SET @pID = NEWID();
INSERT INTO Product (ID,Name, Description) VALUES (@pID,'Name 12',NULL)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 01', NULL, 25,27,29)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 02', NULL, 35,37,39)
SET @pID = NEWID();
INSERT INTO Product (ID,Name, Description) VALUES (@pID,'Name 13',NULL)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 01', NULL, 55,57,59)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 02', NULL, 65,67,69)
SET @pID = NEWID();
INSERT INTO Product (ID,Name, Description) VALUES (@pID,'Name 14',NULL)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 01', NULL, 75,77,79)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 02', NULL, 85,87,89)
SET @pID = NEWID();
INSERT INTO Product (ID,Name, Description) VALUES (@pID,'Name 15',NULL)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 01', NULL, 95,97,99)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 02', NULL, 95,97,199)
SET @pID = NEWID();
INSERT INTO Product (ID,Name, Description) VALUES (@pID,'Name 16',NULL)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 01', NULL, 105,107,199)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 02', NULL, 195,197,200)
SET @pID = NEWID();
INSERT INTO Product (ID,Name, Description) VALUES (@pID,'Name 17',NULL)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 01', NULL, 115,117,200)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 02', NULL, 205,207,210)

