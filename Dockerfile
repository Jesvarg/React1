# Usa la imagen base de Node.js (versión moderna)
FROM node:20 AS build

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia los archivos necesarios para instalar dependencias
COPY package*.json ./

# Instala las dependencias
RUN npm install --legacy-peer-deps

# Copia el resto del código fuente
COPY . .

# Construye la aplicación
RUN npm run build

# Usa la imagen base de Nginx para servir la aplicación
FROM nginx:alpine

# Copia los archivos de construcción al directorio de Nginx
COPY --from=build /app/build /usr/share/nginx/html

# Exponer el puerto 80
EXPOSE 80

# Comando para ejecutar Nginx
CMD ["nginx", "-g", "daemon off;"]
