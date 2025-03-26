# Usa la imagen base de Node.js
FROM node:16 AS build

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia los archivos necesarios para instalar dependencias
COPY package*.json ./

# Instala las dependencias
RUN npm install

# Asegurar permisos de ejecución en binarios de node_modules
RUN chmod -R 777 /app/node_modules

# Copia el resto del código fuente
COPY . .

# Construye la aplicación
RUN npm run build

# Usa la imagen base de Nginx para servir la aplicación
FROM nginx:alpine

# Copia los archivos de construcción al directorio de Nginx
COPY --from=0 /app/build /usr/share/nginx/html

# Exponer el puerto 80
EXPOSE 80

# Comando para ejecutar Nginx
CMD ["nginx", "-g", "daemon off;"]