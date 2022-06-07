import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import Filter = require("bad-words");

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

const MAX_MESSAGES = 200;

export const removeOld = functions.pubsub
  .schedule("0 0 1 * *")
  .onRun(async (context) => {
    const docs = await admin
      .firestore()
      .collection("/messages")
      .orderBy("sent", "desc")
      .get();

    if (docs.docs.length > MAX_MESSAGES) {
      functions.logger.log({
        action: "Remove old",
        initialLength: docs.docs.length,
      });

      for (let i = MAX_MESSAGES; i < docs.docs.length; i++) {
        await admin.firestore().doc(`/messages/${docs.docs[i].id}`).delete();
      }
    }
  });
