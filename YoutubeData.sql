CREATE TABLE UserInfo (
    UserID NUMBER PRIMARY KEY,
    Age NUMBER,
);

INSERT INTO UserInfo (UserID, Age)
VALUES (1, 25);

INSERT INTO UserInfo (UserID, Age)
VALUES (2, 30);

INSERT INTO UserInfo (UserID, Age)
VALUES (3, 20);

INSERT INTO UserInfo (UserID, Age)
VALUES (4, 50);

COMMIT;

