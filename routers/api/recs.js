const { Router } = require('express');
// Controller
const {
    getRecs
} = require('../../controllers/RecsController');

const router = Router();

router.post('/', getRecs);

module.exports = router;