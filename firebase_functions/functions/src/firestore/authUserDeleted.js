const { getFirestore } = require("firebase-admin/firestore");
const logger = require("firebase-functions/logger");

const db = getFirestore();

const deleteUserDoc = async (user) => {
	// Get the user ID (UID) from the user object
	const uid = user.uid;

	try {
		// Attempt to delete the user document from the "users" collection
		await db.collection("users").doc(uid).delete();
		logger.info(`Successfully deleted user document with UID: ${uid}`);
	} catch (error) {
		// Log any errors that occur during the deletion
		logger.warn(`Error deleting user document with UID: ${uid}`, error);
	}
};

module.exports = { deleteUserDoc };
