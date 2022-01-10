const express = require('express');
const mongoose = require('mongoose');
const app = express();
const port = 3000;

const dbURI = 'mongodb+srv://shibingong:acRWZ6nb7wQGcADe@cluster0.28iuv.mongodb.net/yyDB?retryWrites=true&w=majority';
const userRoute = require("./route/user");

mongoose.connect(dbURI)
    .then((result) => app.listen(port, () => {
        console.log(`App listening at http://localhost:${port}`)
    }))
    .catch((err) => console.log(err));

app.get('/', (req, res) => {
    res.send('Welcome to YumYum Server Side')
})

app.use("/user", userRoute);

