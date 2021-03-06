USE [master]
GO
/****** Object:  Database [agilesoft]    Script Date: 20-11-2020 23:51:46 ******/
CREATE DATABASE [agilesoft]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'agilesoft', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\agilesoft.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'agilesoft_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\agilesoft_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [agilesoft] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [agilesoft].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [agilesoft] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [agilesoft] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [agilesoft] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [agilesoft] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [agilesoft] SET ARITHABORT OFF 
GO
ALTER DATABASE [agilesoft] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [agilesoft] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [agilesoft] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [agilesoft] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [agilesoft] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [agilesoft] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [agilesoft] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [agilesoft] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [agilesoft] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [agilesoft] SET  DISABLE_BROKER 
GO
ALTER DATABASE [agilesoft] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [agilesoft] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [agilesoft] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [agilesoft] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [agilesoft] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [agilesoft] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [agilesoft] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [agilesoft] SET RECOVERY FULL 
GO
ALTER DATABASE [agilesoft] SET  MULTI_USER 
GO
ALTER DATABASE [agilesoft] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [agilesoft] SET DB_CHAINING OFF 
GO
ALTER DATABASE [agilesoft] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [agilesoft] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [agilesoft] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [agilesoft] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'agilesoft', N'ON'
GO
ALTER DATABASE [agilesoft] SET QUERY_STORE = OFF
GO
USE [agilesoft]
GO
/****** Object:  Table [dbo].[log_errores]    Script Date: 20-11-2020 23:51:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[log_errores](
	[id_log_errores] [int] IDENTITY(1,1) NOT NULL,
	[error_log_errores] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_log_errores] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tareas]    Script Date: 20-11-2020 23:51:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tareas](
	[id_tarea] [int] IDENTITY(1,1) NOT NULL,
	[nombre_tarea] [varchar](100) NULL,
	[estado_tarea] [varchar](30) NULL,
	[descripcion_tarea] [varchar](300) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_tarea] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usuario]    Script Date: 20-11-2020 23:51:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usuario](
	[id_usuario] [int] IDENTITY(1,1) NOT NULL,
	[username_usuario] [varchar](100) NULL,
	[password_usuario] [varchar](max) NULL,
	[nombre_usuario] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[pa_iniciar_sesion]    Script Date: 20-11-2020 23:51:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[pa_iniciar_sesion] --'bjara','perro123'
	@username_usuario varchar(100),
	@password_usuario varchar(max)
as
begin
	declare @retorno varchar(2)

	begin try
		select * from usuario
		where username_usuario= @username_usuario
		and cast(DECRYPTBYPASSPHRASE('agilesoft',password_usuario) as varchar(max)) = @password_usuario

	end try
	begin catch 
		set @retorno = '1'
		insert into log_errores values (ERROR_message())
	end catch

end
GO
/****** Object:  StoredProcedure [dbo].[pa_inserta_usuario]    Script Date: 20-11-2020 23:51:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[pa_inserta_usuario]
	@username_usuario varchar(100),
	@password_usuario varchar(max),
	@nombre_usuario varchar(200)
as
begin
	declare @retorno varchar(2)

	begin try
		insert into usuario values(@username_usuario,ENCRYPTBYPASSPHRASE('agilesoft',@password_usuario),@nombre_usuario)
		set @retorno = '0'
	end try
	begin catch 
		set @retorno = '1'
		insert into log_errores values (ERROR_message())
	end catch

	select @retorno as retorno
end


GO
/****** Object:  StoredProcedure [dbo].[sp_actualiza_tarea]    Script Date: 20-11-2020 23:51:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_actualiza_tarea]
			@id_tarea int

as
begin
	declare @retorno varchar(2)
	begin try
		update tareas 
		set estado_tarea = 'Resuelto'
		where id_tarea = @id_tarea

		set @retorno = '0'	end try
	begin catch 
		set @retorno = '1'
		insert into log_errores values (ERROR_message())
	end catch

	select @retorno as retorno
	
end

GO
/****** Object:  StoredProcedure [dbo].[sp_inserta_tarea]    Script Date: 20-11-2020 23:51:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_inserta_tarea]
			@nombre_tarea varchar(100),
			@estado_tarea varchar(30),
			@descripcion_tarea varchar(300)
as
begin
	declare @retorno varchar(2)
	begin try
		insert into tareas values(@nombre_tarea,@estado_tarea,@descripcion_tarea)
		set @retorno = '0'
	end try
	begin catch 
		set @retorno = '1'
		insert into log_errores values (ERROR_message())
	end catch

	select @retorno as retorno
	
end

GO
/****** Object:  StoredProcedure [dbo].[sp_lista_tareas]    Script Date: 20-11-2020 23:51:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_lista_tareas]
as
begin
	select id_tarea,
			nombre_tarea,
			estado_tarea,
			descripcion_tarea
	from tareas
end
GO
USE [master]
GO
ALTER DATABASE [agilesoft] SET  READ_WRITE 
GO
