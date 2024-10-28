const { getFirestore, Timestamp } = require("firebase-admin/firestore");
const logger = require("firebase-functions/logger");

const db = getFirestore();

const createUserDoc = async (user) => {
	// Extract user details from the auth object
	const {
		uid,
		email,
		displayName = "",
		emailVerified = false,
	} = user;

	// Create a new user document in Firestore
	try {
		await db.collection("users").doc(uid).set({
			created: Timestamp.now(),
			updated: Timestamp.now(),
			email: email,
			display_name: displayName,
			email_verified: emailVerified,
			status: 0,
			group_id: null,
		});
		logger.info(`Successfully created new user with UID: ${uid}`);
	} catch (error) {
		logger.warn("Error creating user document:", error);
		return -1;
	}
};

module.exports = { createUserDoc };
