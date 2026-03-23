CREATE TABLE [dbo].[Marcas] (
    [Id]     UNIQUEIDENTIFIER NOT NULL,
    [Nombre] VARCHAR (MAX)    NOT NULL,
    CONSTRAINT [PK_Marcas] PRIMARY KEY CLUSTERED ([Id] ASC)
);

CREATE TABLE [dbo].[Modelos] (
    [Id]      UNIQUEIDENTIFIER NOT NULL,
    [IdMarca] UNIQUEIDENTIFIER NOT NULL,
    [Nombre]  VARCHAR (MAX)    NOT NULL,
    CONSTRAINT [PK_Modelos] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Modelos_Marcas] FOREIGN KEY ([IdMarca]) REFERENCES [dbo].[Marcas] ([Id])
);

CREATE TABLE [dbo].[Vehiculo] (
    [Id]                  UNIQUEIDENTIFIER NOT NULL,
    [IdModelo]            UNIQUEIDENTIFIER NOT NULL,
    [Placa]               VARCHAR (MAX)    NOT NULL,
    [Color]               VARCHAR (MAX)    NOT NULL,
    [Anio]                INT              NOT NULL,
    [Precio]              DECIMAL (18, 2)  NOT NULL,
    [CorreoPropietario]   VARCHAR (MAX)    NOT NULL,
    [TelefonoPropietario] VARCHAR (MAX)    NOT NULL,
    CONSTRAINT [PK_Vehiculo] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Vehiculo_Modelos] FOREIGN KEY ([IdModelo]) REFERENCES [dbo].[Modelos] ([Id])
);



-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE ObtenerVehiculos
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Vehiculo.Id, Vehiculo.IdModelo, Vehiculo.Placa, Vehiculo.Color, Vehiculo.Anio, Vehiculo.Precio, 
	Vehiculo.CorreoPropietario, Vehiculo.TelefonoPropietario 
	FROM Vehiculo 
	INNER JOIN Modelos ON Vehiculo.IdModelo = Modelos.Id 
	INNER JOIN Marcas ON Modelos.IdMarca = Marcas.Id
END
GO

CREATE PROCEDURE EliminarVehiculos
	-- Add the parameters for the stored procedure here
	@Id uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE
	FROM Vehiculo 
	WHERE (Vehiculo.Id = @Id)
END
GO

CREATE PROCEDURE InsertarVehiculos
	-- Add the parameters for the stored procedure here
	@Id AS uniqueidentifier,
	@IdModelo AS uniqueidentifier,
	@Placa AS Varchar(MAX),
	@Color AS Varchar(MAX),
	@Anio AS INT,
	@Precio AS Decimal(18,2),
	@CorreoPropietario AS Varchar(MAX),
	@TelefonoPropietario AS Varchar(MAX)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[Vehiculo]
           ([Id]
           ,[IdModelo]
           ,[Placa]
           ,[Color]
           ,[Anio]
           ,[Precio]
           ,[CorreoPropietario]
           ,[TelefonoPropietario])
     VALUES
           (@Id,
		    @IdModelo,
		    @Placa,
		    @Color,
		    @Anio,
			@Precio,
			@CorreoPropietario,
			@TelefonoPropietario)
END
GO

CREATE PROCEDURE EditarVehiculos
	-- Add the parameters for the stored procedure here
	@Id AS uniqueidentifier,
	@IdModelo AS uniqueidentifier,
	@Placa AS Varchar(MAX),
	@Color AS Varchar(MAX),
	@Anio AS INT,
	@Precio AS Decimal(18,2),
	@CorreoPropietario AS Varchar(MAX),
	@TelefonoPropietario AS Varchar(MAX)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[Vehiculo]
	SET
           [IdModelo] = @IdModelo
           ,[Placa] = @Placa
           ,[Color] = @Color
           ,[Anio] = @Anio
           ,[Precio] = @Precio
           ,[CorreoPropietario] = @CorreoPropietario
           ,[TelefonoPropietario] = @TelefonoPropietario
     WHERE Id = @Id
END
GO

