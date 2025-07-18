const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const { keyValueRouter } = require('./routes/store');
const { healthRouter } = require('./routes/health');

const app = express();

app.use(bodyParser.json());
app.use('/health', healthRouter);
app.use('/store', keyValueRouter);

console.log('Connecting to DB');
mongoose
  .connect(
    `mongodb://${process.env.MONGODB_HOST}/${process.env.KEY_VALUE_DB}`,
    {
      auth: {
        username: process.env.KEY_VALUE_USERNAME,
        password: process.env.KEY_VALUE_PASSWORD,
      },
      connectTimeoutMS: 500,
    }
  )
  .then(() => {
    app.listen(3000, () => {
      console.log(`Listening on port 3000`);
    });
    console.log('Connected to DB');
  })
  .catch((err) => {
    console.error('Something went wrong!');
    console.error(err);
  });