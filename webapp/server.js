const express = require("express");
const path = require("path");
const session = require("express-session");

const { createPool, loadEnv } = require("./db");
const { renderPage, setFlash } = require("./helpers");
const { registerRoutes } = require("./routes");

loadEnv(path.join(__dirname, ".env"));

const app = express();
const isProduction = process.env.NODE_ENV === "production";
const port = Number(process.env.PORT || 3000);
const host = "0.0.0.0";
const pool = createPool(process.env);

app.set("trust proxy", 1);
app.disable("x-powered-by");

app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, "public")));
app.use(
  session({
    secret: process.env.SESSION_SECRET || "museum-session-secret",
    resave: false,
    saveUninitialized: false,
    cookie: {
      httpOnly: true,
      sameSite: "lax",
      secure: isProduction,
      maxAge: 1000 * 60 * 60 * 8,
    },
  }),
);

registerRoutes(app, { pool });

app.get("/health", (req, res) => {
  res.status(200).json({ ok: true });
});

app.use((req, res) => {
  res.status(404).send(renderPage({
    title: "Not Found",
    user: req.session.user,
    content: '<section class="card narrow"><h1>Page not found</h1></section>',
  }));
});

app.use((err, req, res, next) => {
  console.error(err);
  setFlash(
    req,
    err && (err.sqlMessage || err.message) ? (err.sqlMessage || err.message) : "Unexpected error.",
  );
  res.redirect(req.headers.referer || "/");
});

app.listen(port, host, () => {
  console.log(`Museum login app running on http://${host}:${port}`);
});
