# Toma de referencia la imagen de node:19.2-alpine3.16
# Carpetas ya integradas: /app /usr /lib
# FROM --platform=linux/amd64 node:19.2-alpine3.16
FROM --platform=$BUILDPLATFORM node:19.2-alpine3.16

# Movernos de directorio: cd app
WORKDIR /app

# Copiar los archivos necesarios de la app
# y pegarlo en el directorio que nos interesa
COPY package.json ./

# Instalar las dependencias
RUN npm install

# Copia todo los archivos y directorios del proyecto
# y pegarlo en el WORKDIR
# Excluyendo todo lo que se encuentre en el .dockerignore
COPY . .

# Realizar testing
RUN npm run test

# Eliminar archivos y directorios no necesariso en PROD
RUN rm -rf test && rm -rf node_modules

# Instalar unicamente las dependencias de PROD
RUN npm install --prod

# Comando run de la imagen
CMD [ "node", "app.js" ]