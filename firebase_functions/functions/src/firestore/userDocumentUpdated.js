const { logger } = require("firebase-functions");
const admin = require("firebase-admin");
const { Timestamp } = require("firebase-admin/firestore");

const onUserDocumentUpdate = async (change, context) => {
	try {
		const { after: { id } } = change.data();
		const userRef = admin.firestore().collection("users").doc(id);

		await userRef.update({
			updated: Timestamp.now(),
		});

		logger.info(`Updated "updated" field for user document: ${id}`);
	} catch (error) {
		logger.error("Error updating user document:", error);
	}
};

module.exports = { onUserDocumentUpdate };
