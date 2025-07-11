const express = require('express');
const path = require('path');
const cors = require('cors');
const { measureMemory } = require('vm');
const mysql = require('mysql2');


// Constants
const publicPath = path.join(__dirname, 'public');
const app = express();
const port = 4000;


// Middleware
app.use(express.static(publicPath));
app.use(express.urlencoded({ extended: true }));
app.use(cors());
app.use(express.json());

// Connect to MYSQL once on server startup
const connection = mysql.createConnection({
  host: 'localhost',  // <- Your RDS endpoint
  user: 'root',                                // <- Your DB username
  password: 'redhat',                     // <- Your DB password
  database: 'mysql',               // <- The DB you created
  port: 3306                                     // Default MySQL port
});

connection.connect((err) => {
  if (err) {
    return console.error('Error connecting: ' + err.stack);
  }
  console.log('Connected to RDS MySQL as ID ' + connection.threadId);
});


  connection.query("CREATE DATABASE if not exists mydb", function (err, result) {
    if (err) throw err;
    console.log("Database created");
  });

  var sql = "CREATE TABLE IF NOT EXISTS customers (message VARCHAR(255))";
  connection.query(sql, function (err, result) {
    if (err) throw err;
    console.log("Table created");
  });

  sql = "INSERT INTO customers (message) VALUES ('First Message')";
  connection.query(sql, function (err, result) {
    if (err) throw err;
    console.log("1 record inserted");
  });

  connection.query("SELECT * FROM customers", function (err, result, fields) {
    if (err) throw err;
    console.log(result);
  });

connection.end();

// Routes
app.get('/home', (req, res) => {
  res.send('Welcome to my page');
});

// app.get('/fetch',async (req, res) => {
//   // console.log("fetched Data is : ",await fetchData())
//   const messages=await fetchData();
//   // res.sendFile(`${publicPath}/index.html`);
//   res.json({messages});
// });

app.get('/page',async (req, res) => {
  res.sendFile(path.join(__dirname, 'index.html'));
})


// app.post('/submit', async (req, res) => {
//   const { data } = req.body;

//   if (!data) {
//     return res.status(400).json({ error: 'No data received' });
//   }
//   try {
//     await storeData(data);
//     res.redirect('/page');
//   } catch (error) {
//     console.error('Error storing data:', error);
//     res.status(500).json({ error: 'Failed to store data' });
//   }
// });

// Start the server
app.listen(port, () => {
  console.log(`Webserver is running on port: ${port}`);
});



// Function to store data in MongoDB
// async function storeData(data) {
  // try {
  //   const collection = db.collection('node-react-collection');
  //   await collection.insertOne({ Response: data });
  //   console.log('Data inserted:', data);
  // } catch (error) {
  //   console.error('Error inserting data:', error);
  //   throw error;
  // }
// }

// async function fetchData() {
  // try{
  //     const collection = await db.collection('node-react-collection');
  //     const messages = await collection.find({}).toArray();
  //     return  messages
  // }catch(error){
  //     console.log(error)
  // }
// }
