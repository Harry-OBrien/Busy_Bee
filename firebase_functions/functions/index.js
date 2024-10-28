const functions = require("firebase-functions/v1");
const { initializeApp } = require("firebase-admin/app");
const { onDocumentUpdated } = require("firebase-functions/v2/firestore");

const REGION = "europe-west1";
initializeApp();

const { createUserDoc } = require("./src/firestore/authUserCreated");
const { deleteUserDoc } = require("./src/firestore/authUserDeleted");
const { onUserDocumentUpdate } = require("./src/firestore/userDocumentUpdated");

// Firestore and Firebase auth
exports.createUserDoc = functions.region(REGION)
	.auth.user()
	.onCreate(createUserDoc);

exports.deleteUserDoc = functions.region(REGION)
	.auth.user()
	.onDelete(deleteUserDoc);

exports.onUserDocumentUpdate = onDocumentUpdated(
	{
		document: "users/{userId}",
		region: REGION,
	},
	onUserDocumentUpdate);
