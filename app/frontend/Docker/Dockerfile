FROM node:lts-jod
WORKDIR app/
COPY ./vite-react-project/package.json .
RUN npm install
COPY ./vite-react-project/ .
CMD ["npm", "run", "dev", "--", "--host"]

