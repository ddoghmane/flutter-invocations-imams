const express = require("express");
const cors = require("cors");
const { MongoClient } = require("mongodb");

const app = express();

app.use(cors());
app.use(express.json());

const client = new MongoClient("mongodb://127.0.0.1:27017");

async function start() {
  await client.connect();

  const db = client.db("chemins_spirituels");
  const imamsDb = client.db("imams");

  console.log("✅ Connecté à MongoDB");

  // ======================
  // INVOCATIONS
  // ======================

  app.get("/api/invocations", async (req, res) => {
    const data = await db
      .collection("invocations")
      .find()
      .toArray();

    res.json(data);
  });

  app.get("/api/invocations/sheikh/:name", async (req, res) => {
    const name = req.params.name;

    const data = await db
      .collection("invocations")
      .find({
        $or: [
          { imam: name },
          { sheikh: name }
        ]
      })
      .toArray();

    res.json(data);
  });

  app.get("/api/invocations/random/:name", async (req, res) => {
    const name = req.params.name;

    const data = await db
      .collection("invocations")
      .aggregate([
        {
          $match: {
            $or: [
              { imam: name },
              { sheikh: name }
            ]
          }
        },
        {
          $sample: { size: 1 }
        }
      ])
      .toArray();

    res.json(data[0] || {});
  });

  app.get("/api/sheikhs", async (req, res) => {
    const sheikhs = await db
      .collection("invocations")
      .distinct("sheikh");

    const imams = await db
      .collection("invocations")
      .distinct("imam");

    const resultat = [...new Set([...sheikhs, ...imams])]
      .filter(Boolean)
      .sort();

    res.json(resultat);
  });

  // ======================
  // IMAMS
  // ======================

  app.get("/api/imams", async (req, res) => {
    const imams = await imamsDb
      .collection("imams")
      .find()
      .toArray();

    res.json(imams);
  });

  app.get("/api/imams/:nom", async (req, res) => {
    const imam = await imamsDb
      .collection("imams")
      .findOne({
        nom: req.params.nom
      });

    if (!imam) {
      return res.status(404).json({
        erreur: "Imam introuvable"
      });
    }

    res.json(imam);
  });

  // ======================
  // SERVEUR
  // ======================

  app.listen(4000, () => {
    console.log("🚀 API en écoute sur http://localhost:4000");
  });
}

start().catch(console.error);
