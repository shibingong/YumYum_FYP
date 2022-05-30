// login route
const express = require("express");
const router = express.Router();

const loginController = require("../controller/loginController");

router.post("/", loginController.checkCredential);
router.post("/admin", loginController.adminLogin);

module.exports = router;