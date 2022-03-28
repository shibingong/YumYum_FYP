// login route
const express = require("express");
const router = express.Router();

const loginController = require("../controller/loginController");

router.post("/", loginController.checkCredential);

module.exports = router;