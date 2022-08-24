const express = require('express');
const mongoose = require('mongoose');
const cors = require("cors");
const app = express();
const port = process.env.PORT || 3000;

const dbURI = 'mongodb+srv://shibingong:acRWZ6nb7wQGcADe@cluster0.28iuv.mongodb.net/YumYumDB?retryWrites=true&w=majority';
const UserAuthMiddleware = require("./middleware/auth");
const loginRoute = require("./route/login");
const registrationRoute = require("./route/registration");
const userRoute = require("./route/user");
const recipeRoute = require("./route/recipe");
const nutritionRoute = require("./route/nutrition");
const feedbackRoute = require("./route/feedback");

mongoose.connect(dbURI)
    .then((result) => app.listen(port, () => {
        console.log(`App listening at PORT ->${port}`)
    }))
    .catch((err) => console.log(err));

app.use(express.static("public"));

app.use(express.json({ limit: "50mb" }));
app.use(express.urlencoded({ limit: "50mb", extended: true }));
app.use(express.json());
app.use(cors());

app.get('/', (req, res) => {
    res.send('Welcome to YumYum Server Side')
})

app.use("/login", loginRoute);
app.use("/user", UserAuthMiddleware, userRoute);
app.use("/register", registrationRoute);
app.use("/recipe", UserAuthMiddleware, recipeRoute);
app.use("/nutrition", UserAuthMiddleware, nutritionRoute);
app.use("/feedback", UserAuthMiddleware, feedbackRoute);


