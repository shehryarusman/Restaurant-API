const { Router } = require('express');
// API routers
const authRouter = require('./api/auth');
const usersRouter = require('./api/users');
const imagesRouter = require('./api/images');
const takeoutRouter = require('./api/takeout');
const feedRouter = require('./api/feed');
const postsRouter = require('./api/posts');
const commentsRouter = require('./api/comments');
const contentsRouter = require('./api/contents');
const chatsRouter = require('./api/chats');
const recsRouter = require('./api/recs');
// Middleware
const requireAuth = require('../middleware/requireAuth');
const getTargetResource = require('../middleware/getTargetResource');

const router = Router();

const pool = new Pool({
    user: process.env.DB_USER,
    host: process.env.DB_HOST,
    database: process.env.DB_NAME,
    password: process.env.DB_PASSWORD,
    port: process.env.DB_PORT,
  });

router.get('/', requireAuth, (req, res) => {
    res.status(200).send(req.user.id);
});
router.get('/help', (req, res) => {
    res.redirect('/documentation');
});
router.get('/documentation', (req, res) => {
    res.sendFile('documentation/index.html');
});
router.get('/health', (req, res) => {
    res.status(200).send('OK');
});
router.get('/dbHealthCheck', async (req, res) => {
    try {
      // Attempt to connect to the database
      const client = await pool.connect();
  
      // Release the client back to the pool
      client.release();
  
      // If connection is successful, respond with success
      res.status(200).send('Database connection successful');
    } catch (error) {
      res.status(500).send('Database connection failed');
    }
});

router.use(getTargetResource);
router.use('/auth', authRouter);
router.use('/users', usersRouter);
router.use('/images', imagesRouter);
router.use('/takeout', requireAuth, takeoutRouter);
router.use('/feed', requireAuth, feedRouter);
router.use('/posts', requireAuth, contentsRouter, postsRouter);
router.use('/comments', requireAuth, contentsRouter, commentsRouter);
router.use('/contents', requireAuth, contentsRouter);
router.use('/chats', requireAuth, chatsRouter);
router.use('/recs', recsRouter);
router.use((err, req, res, next) => {
    if(err) return res.status(err.status || 500).send(err.message);
    next();
});

module.exports = router;