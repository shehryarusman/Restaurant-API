// The purpose of this file is to validate that certain fields are formatted correctly
const { calculateAge } = require('./calculations');

// Check that email is formatted correctly
const validEmail = (email) => {
    // Check formatting using Regex magic
    const reg = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return reg.test(String(email).toLowerCase());
};

// Check that username is formatted correctly
const validUsername = (username) => {
    const reg = /^(?=[a-zA-Z0-9._]{2,20}$)(?!.*[_.]{2})[^_.].*[^_.]$/;
    return reg.test(String(username).toLowerCase());
};

// Takes in a user object and checks that all fields are valid
const userValidationIssue = (user) => {
    const {
        email,
        username,
        firstName,
        lastName,
        dob
    } = user;

    return (
        !email
            ? "No email provided" :
        !validEmail(email)
            ? "Not a valid email" : 
        !username
            ? "No username provided" :
        !validUsername(username)
            ? "Not a valid username" :
        !dob
            ? "No date of birth provided" :
        calculateAge(new Date(dob)) < 13
            ? "Must be at least 13 years old to create an account" :
        !firstName || firstName.length == 0
            ? "No first name provided" :
        firstName.length > 255
            ? "First name too long" :
        !lastName || lastName.length == 0
            ? "No last name provided" :
        lastName.length > 255
            ? "last name too long" : null
    );
};

module.exports = {
    validEmail,
    validUsername,
    userValidationIssue
};
