# Usa la imagen base de Node.js
FROM node:16 AS build

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia los archivos necesarios para instalar dependencias
COPY package.json package-lock.json ./

# Instala las dependencias sin usar la caché de node_modules
RUN npm install

# Asegurar permisos de ejecución en binarios de node_modules
RUN chmod -R 777 node_modules/.bin

# Copia el resto del código de la app
COPY . .

# Construye la aplicación para producción
RUN npm run build

# Usa una imagen más ligera para servir la app
FROM nginx:alpine

# Copia los archivos de construcción a la carpeta pública de Nginx
COPY --from=build /app/build /usr/share/nginx/html

# Exponer el puerto 80
EXPOSE 80

# Comando para ejecutar Nginx
CMD ["nginx", "-g", "daemon off;"]
