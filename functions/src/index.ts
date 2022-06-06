import * as functions from "firebase-functions";
import Filter = require("bad-words");

// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript
export const censorMessages = functions.firestore
  .document("/messages/{documentId}")
  .onCreate((snap, context) => {
    const original: string = snap.data().text;

    const filter = new Filter();

    if (filter.isProfane(original)) {
      const result = filter.clean(original);

      functions.logger.log(
        "Censor",
        context.params.documentId,
        original,
        result
      );

      return snap.ref.set({ text: result }, { merge: true });
    }
    return null;
  });
