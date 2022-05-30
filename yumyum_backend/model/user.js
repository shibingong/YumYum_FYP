// user model
const mongoose = require("mongoose");
// const ObjectId = Schema.ObjectId;

const userSchema = new mongoose.Schema({
    name: String,
    username: String,
    password: String,
    address: String,
    email: String,
    profileImage: String,
}, { versionKey: false });

const User = mongoose.model('users', userSchema);

module.exports = User;