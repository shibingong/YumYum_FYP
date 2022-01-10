// user route
const express = require("express");
const User = require("../model/user");
const router = express.Router();

const userController = require("../controller/userController");

router.get("/", userController.getAllUser);

module.exports = router;