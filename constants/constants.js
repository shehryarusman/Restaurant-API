const path = require('path');

const CONSTANTS = {
    PORT: process.env.PORT || 8080,
    API_ENDPOINT: 'https://api.RestaurantApp-Api.social',
    getRootDirectory: () => {
        // Debugging: Log the __dirname and calculated root directory
        console.debug('Current directory:', __dirname);
        const rootDirectory = path.resolve(path.join(__dirname, '../'));
        console.debug('Root directory:', rootDirectory);

        return rootDirectory;
    }
};

// Debugging: Log the values of PORT and API_ENDPOINT
console.debug('PORT:', CONSTANTS.PORT);
console.debug('API_ENDPOINT:', CONSTANTS.API_ENDPOINT);

module.exports = CONSTANTS;