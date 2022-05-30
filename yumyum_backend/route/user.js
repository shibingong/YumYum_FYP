// user route
const express = require("express");
const router = express.Router();

const userController = require("../controller/userController");

router.get("/all", userController.getAllUser);
router.get("/", userController.getUser);
router.get("/:id", userController.getUserById);
router.put("/", userController.updateUser);
router.put("/:id", userController.updateUserById);
router.put("/uploadImage", userController.uploadImage);
router.delete("/:id", userController.deleteUserById);

module.exports = router;