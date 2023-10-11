
drop table  Usuarios
CREATE TABLE Usuarios (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(255),
    Apellido NVARCHAR(255),
    Matricula NVARCHAR(50) UNIQUE, -- Asegura que la matr�cula sea �nica
    Email NVARCHAR(255) UNIQUE ,
    Contrase�a NVARCHAR(255)
);


drop PROCEDURE sp_AltaUsuario
CREATE PROCEDURE sp_AltaUsuario
    @Nombre NVARCHAR(255),
    @Apellido NVARCHAR(255),
    @Matricula NVARCHAR(50),
    @Email NVARCHAR(255),
    @Contrase�a NVARCHAR(255)
AS
BEGIN
    -- Verificar si la matr�cula y el correo electr�nico ya existen en la tabla
    IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE Matricula = @Matricula) 
    AND NOT EXISTS (SELECT 1 FROM Usuarios WHERE Email = @Email)
    BEGIN
        -- Encriptar la contrase�a proporcionada con MD5
        DECLARE @Contrase�aMD5 NVARCHAR(32);
        SET @Contrase�aMD5 = CONVERT(NVARCHAR(32), HASHBYTES('MD5', @Contrase�a), 2);

        INSERT INTO Usuarios (Nombre, Apellido, Matricula, Email, Contrase�a)
        VALUES (@Nombre, @Apellido, @Matricula, @Email, @Contrase�aMD5);
        SELECT 'Si' AS Resultado; -- Devolver una cadena 'Si' si el usuario se inserta con �xito
    END
    ELSE
    BEGIN
        SELECT 'No' AS Resultado; -- Devolver una cadena 'No' si la matr�cula o el correo electr�nico ya existen
    END;
END;

Select * from Usuarios




drop procedure sp_LoginUsuario
CREATE PROCEDURE sp_LoginUsuario
    @Email NVARCHAR(255),
    @Contrase�a NVARCHAR(32) -- MD5 produce una cadena de 32 caracteres
AS
BEGIN
    -- Encriptar la contrase�a proporcionada con MD5
    DECLARE @Contrase�aMD5 NVARCHAR(32);
    SET @Contrase�aMD5 = CONVERT(NVARCHAR(32), HASHBYTES('MD5', @Contrase�a), 2);

    -- Verificar si el correo electr�nico y la contrase�a coinciden
    IF EXISTS (SELECT 1 FROM Usuarios WHERE Email = @Email AND Contrase�a = @Contrase�aMD5)
    BEGIN
        -- Las credenciales son v�lidas, el inicio de sesi�n es exitoso
        SELECT 'Si' AS Resultado; -- Devolver una cadena 'Si'
    END
    ELSE
    BEGIN
        -- Las credenciales son incorrectas, el inicio de sesi�n fall�
        SELECT 'No' AS Resultado; -- Devolver una cadena 'No'
    END;
END;


select * from Usuarios



