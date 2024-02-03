# Toma de referencia la imagen de node:19.2-alpine3.16
# Carpetas ya integradas: /app /usr /lib
# FROM --platform=linux/amd64 node:19.2-alpine3.16
FROM node:19.2-alpine3.16 as deps
# Movernos de directorio: cd app
WORKDIR /app
# Copiar los archivos necesarios de la app
# y pegarlo en el directorio que nos interesa
COPY package.json ./
# Instalar las dependencias
RUN npm install

# Build y test
FROM node:19.2-alpine3.16 as builder
WORKDIR /app
# Copiamos las dependencias del bloque anterior deps
COPY --from=deps /app/node_modules ./node_modules
# Copia todo los archivos y directorios del proyecto
# y pegarlo en el WORKDIR
# Excluyendo todo lo que se encuentre en el .dockerignore
COPY . .
# Realizar testing
RUN npm run test


# Dependencias de produccion
FROM node:19.2-alpine3.16 as prod-deps
WORKDIR /app
COPY package.json ./
# Instalar unicamente las dependencias de PROD
RUN npm install --prod

# Ejecutar la app
FROM node:19.2-alpine3.16 as runner
WORKDIR /app
COPY --from=prod-deps /app/node_modules ./node_modules
# Copiar archivos necesarios
COPY app.js ./
COPY tasks/ ./tasks

# Comando run de la imagen
CMD [ "node", "app.js" ]