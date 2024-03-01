// The purpose of this script is for all email related functions
const nodemailer = require("nodemailer");
let ayodaTransporter = nodemailer.createTransport({
    service: "gmail",
    host: process.env.NOREPLY_EMAIL_HOST,
    port: process.env.NOREPLY_EMAIL_PORT,
    auth: {
        user: process.env.NOREPLY_EMAIL_ADDRESS,
        pass: process.env.NOREPLY_EMAIL_PASSWORD
    }
});


module.exports = {
    ayodaTransporter
};
