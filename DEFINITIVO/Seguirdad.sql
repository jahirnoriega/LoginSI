
drop table  Usuarios
CREATE TABLE Usuarios (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(255),
    Apellido NVARCHAR(255),
    Matricula NVARCHAR(50) UNIQUE, -- Asegura que la matrícula sea única
    Email NVARCHAR(255) UNIQUE ,
    Contraseña NVARCHAR(255)
);


drop PROCEDURE sp_AltaUsuario
CREATE PROCEDURE sp_AltaUsuario
    @Nombre NVARCHAR(255),
    @Apellido NVARCHAR(255),
    @Matricula NVARCHAR(50),
    @Email NVARCHAR(255),
    @Contraseña NVARCHAR(255)
AS
BEGIN
    -- Verificar si la matrícula y el correo electrónico ya existen en la tabla
    IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE Matricula = @Matricula) 
    AND NOT EXISTS (SELECT 1 FROM Usuarios WHERE Email = @Email)
    BEGIN
        -- Encriptar la contraseña proporcionada con MD5
        DECLARE @ContraseñaMD5 NVARCHAR(32);
        SET @ContraseñaMD5 = CONVERT(NVARCHAR(32), HASHBYTES('MD5', @Contraseña), 2);

        INSERT INTO Usuarios (Nombre, Apellido, Matricula, Email, Contraseña)
        VALUES (@Nombre, @Apellido, @Matricula, @Email, @ContraseñaMD5);
        SELECT 'Si' AS Resultado; -- Devolver una cadena 'Si' si el usuario se inserta con éxito
    END
    ELSE
    BEGIN
        SELECT 'No' AS Resultado; -- Devolver una cadena 'No' si la matrícula o el correo electrónico ya existen
    END;
END;

Select * from Usuarios




drop procedure sp_LoginUsuario
CREATE PROCEDURE sp_LoginUsuario
    @Email NVARCHAR(255),
    @Contraseña NVARCHAR(32) -- MD5 produce una cadena de 32 caracteres
AS
BEGIN
    -- Encriptar la contraseña proporcionada con MD5
    DECLARE @ContraseñaMD5 NVARCHAR(32);
    SET @ContraseñaMD5 = CONVERT(NVARCHAR(32), HASHBYTES('MD5', @Contraseña), 2);

    -- Verificar si el correo electrónico y la contraseña coinciden
    IF EXISTS (SELECT 1 FROM Usuarios WHERE Email = @Email AND Contraseña = @ContraseñaMD5)
    BEGIN
        -- Las credenciales son válidas, el inicio de sesión es exitoso
        SELECT 'Si' AS Resultado; -- Devolver una cadena 'Si'
    END
    ELSE
    BEGIN
        -- Las credenciales son incorrectas, el inicio de sesión falló
        SELECT 'No' AS Resultado; -- Devolver una cadena 'No'
    END;
END;


select * from Usuarios



