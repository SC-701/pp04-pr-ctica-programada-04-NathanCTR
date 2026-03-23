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
	
	BEGIN TRANSACTION
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
		 SELECT @Id
	 COMMIT TRANSACTION
END