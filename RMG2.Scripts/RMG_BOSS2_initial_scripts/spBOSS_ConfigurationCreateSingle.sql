ALTER TABLE Person
  ALTER COLUMN LastName VARCHAR(200) NULL;

GO

INSERT INTO Person (firstname, lastname)
VALUES ('John', 'Doe')
GO
