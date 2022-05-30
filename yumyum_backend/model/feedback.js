// user model
const mongoose = require("mongoose");
// const ObjectId = Schema.ObjectId;

const feedbackSchema = new mongoose.Schema({
    id: String,
    comment: String,
    rating: String,
    userID: { type: mongoose.Schema.Types.ObjectId, ref: "users" },
    recipeID: { type: mongoose.Schema.Types.ObjectId, ref: "recipes" },
}, { versionKey: false });

const Feedback = mongoose.model('feedbacks', feedbackSchema);

module.exports = Feedback;