const express = require('express');
const bodyParser = require('body-parser')
const mongoose = require('mongoose');
const app = express();
const port = 3000;

const dbURI = 'mongodb+srv://shibingong:acRWZ6nb7wQGcADe@cluster0.28iuv.mongodb.net/YumYumDB?retryWrites=true&w=majority';
const UserAuthMiddleware = require("./middleware/auth");
const loginRoute = require("./route/login");
const userRoute = require("./route/user");


mongoose.connect(dbURI)
    .then((result) => app.listen(port, () => {
        console.log(`App listening at http://localhost:${port}`)
    }))
    .catch((err) => console.log(err));

app.use(express.static("public"));

app.use(express.json({ limit: "50mb" }));
app.use(express.urlencoded({ limit: "50mb", extended: true }));
app.use(express.json());

app.get('/', (req, res) => {
    res.send('Welcome to YumYum Server Side')
})

app.use("/login", loginRoute);
app.use("/user", UserAuthMiddleware, userRoute);


