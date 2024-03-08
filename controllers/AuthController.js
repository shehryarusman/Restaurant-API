const jwt = require('jsonwebtoken');
const queryDB = require('../queries/queryDB');
const pool = require('../queries/db');
const { userValidationIssue, validEmail, validUsername } = require('../helpers/validators');
// Email Automation
const { ayodaTransporter } = require('../helpers/email');

// Set a verification code to the provided email
// POST /login/:email
const login = async (req, res) => {
    const { email } = req.params;

    // Check that email is formatted properly
    if(!validEmail(email)) return res.status(422).send("Not a valid email");
    
    // Query the database for the user
    const { rows: [ user ] } = await pool.query("SELECT * FROM users WHERE email = $1", [email]);
    // Create a new user if they don't exist
    if(!user) {
        await pool.query("INSERT INTO users (email) VALUES ($1)", [email]);
    }

    // Generate a 5 digit random verification code
    const verificationCode = Array.from({ length: 5 }, () => Math.floor(Math.random() * 10));

    // Update the user's cell to include reset token & expiration date
    await pool.query(
        "UPDATE users SET verification_code = $1, verification_code_expiration = $2 WHERE email = $3",
        [verificationCode.join(""), new Date(Date.now() + 3600000), email]
    );

    // Send automated email to user with reset button
    let mailOptions = {
        to: email,
        from: 'noreply.ayoda.app@gmail.com',
        subject: 'Account Sign In',
        html: `<h2>Your sign in token is</h2><h1>[ ${verificationCode.join(" ")} ]<h1>`
    };
    await ayodaTransporter.sendMail(mailOptions);
    return res.status(200).send("Verification code sent!");
};

// Verify a user's email
// POST /verify
const verify = async (req, res) => {
    const {
        email,
        verificationCode: attemptedVerificationCode
    } = req.body;

    // Get the user associated with the token
    const { rows: [ user ] } = await pool.query("SELECT * FROM users WHERE email = $1", [email]);
    if (!user) {
        return res.status(400).send("No user found with this email");
    }

    // Check that the token is valid & hasn't expired
    const verificationCode = user.verification_code;
    const verificationCodeExpiration = user.verification_code_expiration;
    var now = new Date(Date.now());
    if(verificationCode !== attemptedVerificationCode){
        return res.status(400).send("Invalid verification code");
    }
    if (verificationCodeExpiration > now) {
        return res.status(400).send("Verification code expired");
    }

    // Generate JWT token and attach to response header
    const token = jwt.sign({ userId: user.id }, process.env.TOKEN_KEY);

    return res.status(200).set('authorization', `Bearer ${token}`).send(user);
};

// Populate an empty user cell with it's information
// POST /register/:userId
const register = async (req, res) => {
    const { userId } = req.params;
    const {
        firstName,
        lastName,
        username,
        dob
    } = req.body;

    // User Validation
    if(userValidationIssue = userValidationIssue(req.body) !== null)
        return res.status(403).send(userValidationIssue);

    await pool.query(
        "UPDATE users SET first_name = $1, last_name = $2, username = $3, dob = $4 WHERE id = $5",
        [firstName, lastName, username, dob, userId]
    );

    return res.status(200).send("User registered!");
};

module.exports = {
    login,
    verify,
    register
};
