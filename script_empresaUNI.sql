-- CREACIÓN DE LA BASE DE DATOS 
USE [master]
GO

CREATE DATABASE [EMPRESA_UNI]

USE EMPRESA_UNI
GO
ON PRIMARY 
( 
    NAME = N'EMPRESA_UNI', 
    FILENAME = N'C:\cheche\EMPRESA_UNI.mdf', 
    SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB 
)
LOG ON 
( 
    NAME = N'EMPRESA_UNI_log', 
    FILENAME = N'C:\cheche\EMPRESA_UNI_log.ldf', 
    SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB 
)
WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO


USE [EMPRESA_UNI]
GO

-- LIMPIEZA DE TABLAS (en caso de que existan de un intento anterior)
IF OBJECT_ID('dbo.Directivos', 'U') IS NOT NULL DROP TABLE dbo.Directivos;
IF OBJECT_ID('dbo.Empleado', 'U') IS NOT NULL DROP TABLE dbo.Empleado;
IF OBJECT_ID('dbo.puestos', 'U') IS NOT NULL DROP TABLE dbo.puestos;
IF OBJECT_ID('dbo.centroTrabajo', 'U') IS NOT NULL DROP TABLE dbo.centroTrabajo;
GO

-- CREACIÓN DE LAS TABLAS

-- Tablas de Catálogo
CREATE TABLE [dbo].[centroTrabajo](
    [noCentro] [varchar](6) NOT NULL, 
    [nombreCentro] [varchar](100) NOT NULL,
    [ciudad] [varchar](50) NOT NULL,
 CONSTRAINT [PK_centroTrabajo] PRIMARY KEY CLUSTERED ([noCentro] ASC)
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[puestos](
    [noPuestos] [int] NOT NULL, 
    [puesto] [varchar](50) NOT NULL,
    [descripcion] [varchar](255) NULL,
 CONSTRAINT [PK_puestos] PRIMARY KEY CLUSTERED ([noPuestos] ASC)
) ON [PRIMARY]
GO

-- Tablas Principales
CREATE TABLE [dbo].[Empleado](
    [noEmpleado] [int] IDENTITY(1,1) NOT NULL, 
    [nombre] [varchar](50) NOT NULL,
    [apellidoP] [varchar](50) NOT NULL,
    [apellidoM] [varchar](50) NULL,
    [fechaNacimiento] [date] NOT NULL,
    [RFC] [varchar](13) NULL,
    [centroTrabajo] [varchar](10) NULL, 
    [puesto] [varchar](50) NULL,         
    [descripcionPuesto] [varchar](255) NULL, 
    [directivo] [bit] NOT NULL, 
 CONSTRAINT [PK_Empleado] PRIMARY KEY CLUSTERED ([noEmpleado] ASC)
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Directivos](
    [noEmpleado] [int] NOT NULL, 
    [numeroCentroSupervisa] [int] NULL,
    [prestaciones] [bit] NULL, 
 CONSTRAINT [PK_Directivos] PRIMARY KEY CLUSTERED ([noEmpleado] ASC)
) ON [PRIMARY]
GO

-- Definir la relación de Herencia (FK de Directivos a Empleado)
ALTER TABLE [dbo].[Directivos]  WITH CHECK ADD CONSTRAINT [FK_Directivos_Empleado] FOREIGN KEY([noEmpleado])
REFERENCES [dbo].[Empleado] ([noEmpleado])
GO

ALTER TABLE [dbo].[Directivos] CHECK CONSTRAINT [FK_Directivos_Empleado]
GO

--------------------------------------------------------------------
-- LIMPIEZA INICIAL (Eliminar base de datos si existe)
-----------------------------------------------------------------
USE [master]
GO

IF EXISTS(SELECT name FROM sys.databases WHERE name = N'EMPRESA_UNI')
BEGIN
    PRINT 'La base de datos EMPRESA_UNI ya existe. Intentando eliminarla...'
    -- Poner la base de datos en modo de usuario único para poder eliminarla
    ALTER DATABASE [EMPRESA_UNI] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    -- Eliminar la base de datos
    DROP DATABASE [EMPRESA_UNI];
    PRINT 'Base de datos EMPRESA_UNI eliminada.'
END
ELSE
BEGIN
    PRINT 'La base de datos EMPRESA_UNI no existe. Procediendo con la creación.'
END
GO