const { Router } = require('express');
const {
    login,
    verify,
    register
} = require('../../controllers/AuthController');

const router = Router();

router.post('/login/:email', login);
router.post('/verify', verify);
router.post('/register/:userId', register);

module.exports = router;