// user route
const express = require("express");
const router = express.Router();

const userController = require("../controller/userController");

router.get("/", userController.getAllUser);

module.exports = router;