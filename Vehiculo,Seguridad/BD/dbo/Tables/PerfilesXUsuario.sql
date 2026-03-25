CREATE TABLE [dbo].[PerfilesXUsuario] (
    [IdUsuario] UNIQUEIDENTIFIER NOT NULL,
    [IdPerfil]  INT              NOT NULL,
    CONSTRAINT [PK_PerfilesXUsuario] PRIMARY KEY CLUSTERED ([IdUsuario] ASC, [IdPerfil] ASC),
    CONSTRAINT [FK_PerfilesXUsuario_Perfiles] FOREIGN KEY ([IdPerfil]) REFERENCES [dbo].[Perfiles] ([Id]),
    CONSTRAINT [FK_PerfilesXUsuario_Usuarios] FOREIGN KEY ([IdUsuario]) REFERENCES [dbo].[Usuarios] ([Id])
);

