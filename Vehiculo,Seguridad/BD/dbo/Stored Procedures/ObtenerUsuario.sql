CREATE PROCEDURE [dbo].[ObtenerUsuario]
@NombreUsuario VARCHAR(MAX),
@CorreoElectronico VARCHAR(MAX)
AS
BEGIN
SET NOCOUNT ON;
DECLARE @Id AS UniqueIdentifier =NEWID();
SELECT  Id, NombreUsuario, PasswordHash, CorreoElectronico, FechaCreacion, FechaModificacion, UsuarioCrea, UsuarioModifica
FROM Usuarios 
WHERE (NombreUsuario = @NombreUsuario) OR (CorreoElectronico = @CorreoElectronico)
END