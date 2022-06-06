import * as functions from "firebase-functions";

// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript
export const censorMessages = functions.firestore
  .document("/messages/{documentId}")
  .onCreate((snap, context) => {
    const original: string = snap.data().text;

    if (/.*fuck.*/.test(original)) {
      functions.logger.log("Censor", context.params.documentId, original);

      const result = original.replace("fuck", "****");
      return snap.ref.set({ text: result }, { merge: true });
    }
    return null;
  });
