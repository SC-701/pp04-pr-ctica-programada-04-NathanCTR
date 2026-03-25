USE Autenticacion;


CREATE  TABLE [dbo].[Perfiles](
	[Id]				INT					NOT NULL,
	[Nombre]			VARCHAR (MAX)		NOT NULL,
	[FechaCreacion]		DATETIME			NULL,
	[FechaModificacion]	DATETIME			NULL,
	[UsuarioCrea]		UNIQUEIDENTIFIER	NULL,
	[UsuarioModifica]	UNIQUEIDENTIFIER	NULL,
	CONSTRAINT [PK_Perfiles] PRIMARY KEY CLUSTERED ([Id] ASC)
);

CREATE  TABLE [dbo].[Usuarios](
	[Id]				UNIQUEIDENTIFIER	NOT NULL,
	[NombreUsuario]		VARCHAR (MAX)		NOT NULL,
	[PasswordHash]		VARCHAR (MAX)		NOT NULL,
	[CorreoElectronico]	VARCHAR (MAX)		NOT NULL,
	[FechaCreacion]		DATETIME			NULL,
	[FechaModificacion]	DATETIME			NULL,
	[UsuarioCrea]		UNIQUEIDENTIFIER	NULL,
	[UsuarioModifica]	UNIQUEIDENTIFIER	NULL,
	CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED ([Id] ASC)
);

CREATE  TABLE [dbo].[PerfilesXUsuario](
	[IdUsuario]	UNIQUEIDENTIFIER NOT NULL,
	[IdPerfil]	INT				 NOT NULL,
	CONSTRAINT [PK_PerfilesXUsuario] PRIMARY KEY CLUSTERED ([IdUsuario] ASC, [IdPerfil] ASC),
	CONSTRAINT [FK_PerfilesXUsuario_Perfiles] FOREIGN KEY  ([IdPerfil]) REFERENCES [dbo].[Perfiles]([Id]),
	CONSTRAINT [FK_PerfilesXUsuario_Usuarios] FOREIGN KEY  ([IdUsuario]) REFERENCES [dbo].[Usuarios]([Id])
);

CREATE PROCEDURE [dbo].[AgregarUsuario]
@NombreUsuario VARCHAR(MAX),
@PasswordHash VARCHAR(MAX),
@CorreoElectronico VARCHAR(MAX)
AS
BEGIN
SET NOCOUNT ON;
DECLARE @Id AS UniqueIdentifier =NEWID();
BEGIN TRAN
INSERT INTO [dbo].[Usuarios]
([Id], [NombreUsuario], [PasswordHash], [CorreoElectronico])
VALUES(@Id, @NombreUsuario, @PasswordHash, @CorreoElectronico)
INSERT INTO [dbo].[PerfilesxUsuario]
([IdUsuario], [IdPerfil])
VALUES(@Id, 1)
SELECT  @Id
COMMIT TRAN
END

CREATE PROCEDURE [dbo].[ObtenerPerfilesxUsuario]
@NombreUsuario VARCHAR(MAX),
@CorreoElectronico VARCHAR(MAX)
AS
BEGIN
SET NOCOUNT ON;
DECLARE @Id AS UniqueIdentifier =NEWID();
SELECT  Perfiles.Id, Perfiles.Nombre
FROM Perfiles INNER JOIN PerfilesxUsuario ON Perfiles.Id = PerfilesxUsuario.IdPerfil INNER JOIN
	 Usuarios ON PerfilesxUsuario.IdUsuario = Usuarios.Id
WHERE (Usuarios.NombreUsuario = @NombreUsuario) OR (Usuarios.CorreoElectronico = @CorreoElectronico)
END

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








