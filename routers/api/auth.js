const { Router } = require('express');
const {
    login,
    verify,
    validateParameter,
    register
} = require('../../controllers/AuthController');

const router = Router();

router.post('/login', login);
router.post('/verify', verify);
router.get('/validateParameter/:parameter/:value', validateParameter);
router.post('/register/:userId', register);

module.exports = router;