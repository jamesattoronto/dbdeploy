ALTER TABLE Person
  ALTER COLUMN LastName VARCHAR(300) NOT NULL;

GO

INSERT INTO Person (firstname, lastname)
VALUES ('John 2', 'Doe 2')
GO
