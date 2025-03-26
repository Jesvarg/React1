# Usa la imagen base de Node.js
FROM node:16 AS build

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia los archivos necesarios para instalar dependencias
COPY package.json package-lock.json ./

# Instala las dependencias
RUN npm install

# Instala react-scripts globalmente para evitar errores de permisos
RUN npm ci -g react-scripts

# Asegurar permisos de ejecución en binarios de node_modules
RUN chmod -R 777 /app/node_modules

# Copia el resto del código fuente
COPY . .

# Construye la aplicación
RUN npm run build
