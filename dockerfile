#base image that builds custom image upon
FROM node 
WORKDIR /app
RUN npm install
#which port application will be running on when a container runs from this image
EXPOSE 3000
CMD npm start

